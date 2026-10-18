Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E40314B8F;
	Sun, 18 Oct 2026 02:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289717; cv=none; b=Ku3gdoiTcQ8VgM+/1TR4afRRx7PDQC/vsbRPBp01JkDuILhozo6kjpeOMJ5SLmneZtCWHKKGn6uzZWcpO++vgLxS3wbWdi7Mz+9pAGuQ2MYbnMTsnJUpO9347RqWNZ5UE6o3vty7mpnoTcuoWx+guEU/cMb+T4Pqxw46JxxWEeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289717; c=relaxed/simple;
	bh=UTTezgF4LXlO9HHrXSCy1QrmrcPJCVNMUoH+grdDgNo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H/Qz5UEmXAw3hp9x3gym38TCAMdXuv+cVpA5uRZ/q0RizJB7BO5I0k3VO9EwzaLvARRmGxBkdtGN8ye0puExlmFQv9rxjsTRoh9JuJ30PIy4B1JpAqyyjCHtVwrmV5XhOhjS4AmVNtTfKUPMnHHzXASrcomxCpSs2yjCP513hSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ9XztHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ9XztHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955C91F000C4;
	Sun, 18 Oct 2026 02:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792289716;
	bh=jIls5dj8bj5rcyIbQF57sPPAlBcqB4l0T418yM/KJcA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GZ9XztHteo0ZY8UttEy8ClFfPFsp0UgzcPMDV1I4B61qcJ9D9mVtKHlZ7U2SmCy//
	 dxJk1IInWnXwzPtCz29ngoLSgBTiipHqy9Qd+LgcQVVPAi/jNaDBo9Kdrb40/iRqp6
	 6Un1xvF3AWZOzX3T9q2TSojLMecSdEqo5K03GvY1oRfTXaVqLTjMbSjnFmJ87fbF9f
	 O1Y/EKt8vGQ4LgHumScOKisEXbqtqcA3OBftJVRJJt/xEMgW8j0vJDbTJc2tASGS9y
	 NKXLN9fbZJJvGi9DXdUiw8AKUZE0qz7X690SlP1r5PLAtUvVqsmIjPrG21i6fVPcyu
	 3SLCa1mi+AxNQ==
Subject: Re: [PATCH net] net: free the policies if a socket's clone fails late
From: netdev-bot+sashiko@kernel.org
To: alexei.starovoitov@gmail.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, josef@toxicpanda.com,
 mason@kernel.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 kuba@kernel.org
Date: Sun, 18 Oct 2026 02:15:15 +0000
Message-ID: <179228971515.3135.11305942271655228187@kernel.org>
In-Reply-To: <20261017013912.396296-1-alexei.starovoitov@gmail.com>
References: <20261017013912.396296-1-alexei.starovoitov@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch is incomplete.

--

net: free the policies if a socket's clone fails late

This patch makes sk_clone() call xfrm_sk_free_policy() on the new socket
when bpf_sk_storage_clone() fails. Without it, the cloned IPsec policies
are lost and stay on the netns policy list. The other user of the free
label is left alone, because sk_policy[] may still hold the parent's
pointers there.

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 1302c1e848b2a..cdbd49ff71b0a 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2578,8 +2578,10 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
>  		goto free;
>  	}
>
> -	if (bpf_sk_storage_clone(sk, newsk))
> +	if (bpf_sk_storage_clone(sk, newsk)) {
> +		xfrm_sk_free_policy(newsk);
>  		goto free;
> +	}

[Severity: High]
Can the same policy leak still happen through the branch just above this,
when xfrm_sk_clone_policy() itself fails partway?

The "goto free" in the context above comes from this branch in sk_clone():

net/core/sock.c:sk_clone() {
    ...
	if (unlikely(!is_charged || xfrm_sk_clone_policy(newsk, sk))) {
		if (!is_charged)
			RCU_INIT_POINTER(newsk->sk_filter, NULL);

		goto free;
	}
    ...
}

xfrm_sk_clone_policy() clears both newsk->sk_policy[] slots and then calls
__xfrm_sk_clone_policy(). That loops over both directions:

net/xfrm/xfrm_policy.c:__xfrm_sk_clone_policy() {
    ...
	for (i = 0; i < 2; i++) {
		p = rcu_dereference(osk->sk_policy[i]);
		if (p) {
			np = clone_policy(p, i);
			if (unlikely(!np)) {
				ret = -ENOMEM;
				break;
			}
			rcu_assign_pointer(sk->sk_policy[i], np);
		}
	}
    ...
}

Suppose clone_policy() succeeds for i == 0. The clone is then linked into
net->xfrm.policy_all through xfrm_sk_policy_link() and counted in
policy_count.

Now suppose it fails for i == 1, either because xfrm_policy_alloc() with
GFP_ATOMIC fails or because security_xfrm_policy_clone() fails. The
function returns -ENOMEM and leaves sk_policy[0] attached to newsk.

In that case is_charged is true, so sk_clone() jumps straight to free:.
That path clears sk_destruct and calls sk_free(), and nothing releases
sk_policy[0]. Wouldn't this leave the policy[0] clone on policy_all? That
is the situation the commit message describes for the
bpf_sk_storage_clone() failure.

xfrm_policy_flush() skips socket policies (dir >= XFRM_POLICY_MAX), so the
entry looks like it would still be there at netns teardown and trigger the
WARN_ON(!list_empty(&net->xfrm.policy_all)) in xfrm_policy_fini().

The commit message gives this reason for not freeing on the other user of
the label:

    Free the policies before leaving. This can't be done for all users of the
    label: if the socket filter could not be charged, sk_policy[] still holds
    the pointers of the parent.

This seems to hold only when !is_charged short-circuits the condition, so
that xfrm_sk_clone_policy() never runs. Once xfrm_sk_clone_policy() has
run, sk_policy[] holds only fresh clones or NULL.

Would it be safe to call xfrm_sk_free_policy(newsk) in that sub-case, for
example in an else branch of the !is_charged check? Alternatively,
__xfrm_sk_clone_policy() could roll back the already cloned policy on
partial failure.

For comparison, tcp_v4_send_reset() always calls
xfrm_sk_free_policy(ctl_sk) after xfrm_sk_clone_policy(ctl_sk, sk),
whatever the clone returned.

>
>  	/* Clear sk_user_data if parent had the pointer tagged
>  	 * as not suitable for copying when cloning.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017013912.396296-1-alexei.starovoitov%40gmail.com
