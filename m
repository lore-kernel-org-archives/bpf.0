Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795301682;
	b=0Ufs91AkbzknwxbbJHBEUnkb7Ej7HIsdw+zTOuoGhEdt2ZTGFNsVV1pdp8VMTF2BUwlv
	 jaMyKsoQ/dnOnu4OscQvmEhKD+DEdS4Vu0mD6s4ZtnrzztptiUwqASlLduuWn3ZSIYmts
	 WmOlIe2tMeqlrVzqARklPWEpSQx6hCMr7shMUWQ/fAGx1gAD4S0EZnp+AUYFBkVGRKJQM
	 /OfAtg4QDDyQw4LVENQ7CT/csKecECYq77HpTRzLq/ru8nnYJ8i0eLXdICvOGgMgmGprK
	 73ZngC/Yi4nOVkQtVmgyVpapWIrrJ3puSNYweAmmEJgUyKAAIdJ0fPaXE5jShIOjUpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795301682;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=UQrftRYFItlYpawQYw0m1vSbC14r8+gmct/wReDGYhw=;
	b=ylk6PlcOUlOOruR1Oc5DG2mwtI74Rcs8CkaaCqCNmcIoec/qvv3JAV+igEjUYNB8eQAQ
	 OIninM3oe3/wwiDL3mMDpE3db0yf/DVMST9GzmbORKG5GkzPC8uqZFHF5TZr8oZUIziOV
	 PjHT6GXpNWe86geynXgXUheuOKS3XGqM5fuqdwjC6uaVciqqNg4AeYP59ZouEGT6DG3JH
	 cKslNDso7Vp/Yll8C+Vg4QjNnHBjQs6eZI6DFIbaFBnZuGQGq3piPjvS1mqk2jM4MjwGG
	 DPp98I2RKbdHTbSn14XtaKldZHi1H24QEYVA9rYCLA+9dF/kOoeDqjOdMmeZbupsJYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gD9IHUhu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808F9606A331
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gD9IHUhu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3071F000C0;
	Sat, 21 Nov 2026 22:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795301682;
	bh=UQrftRYFItlYpawQYw0m1vSbC14r8+gmct/wReDGYhw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gD9IHUhuxCGD9w2JlaK9gFEJhLhEQdLD50420ZTE+74C4CYgVCefAz0fkX7Q70UHu
	 hp3Rc5Sai4CqvpZe8x9dSl/y+ooeuoMApGUh5C6SiVK1dG8W0P9DfByexSii/TwHnG
	 3iS9J4MkKxF0nbwXdkZcWNJoJm5SPpp4FRLcSLnYIWul4tXj361GChdXwrylbRc3VJ
	 2PNC6uC/QqE/7g8ToiDDV4/fIeClvoOosjzbJIm4IY5IxaF7EhCRT7Ohtz3S2gXDag
	 EOU/yMWbh967uMybIhoBatGIpOYpyxuyQSVTMdfOCQ4K2c/xaL4x8zRhcLJEFnnAOZ
	 3Z1Du0RzIstnA==
Content-Type: multipart/mixed; boundary="===============3778955900086664236=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <fd0e13d4f823e47e82f697c6d3faaa0e436dd535505ac6f2ce37a0977341b7a7@mail.kernel.org>
In-Reply-To: <20261121221344.3958866-3-alexei.starovoitov@gmail.com>
References: <20261121221344.3958866-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/7] bpf: Do not skip trips if the bound moves
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 21 Nov 2026 22:54:40 +0000 (UTC)

--===============3778955900086664236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Do not skip trips if the bound moves

TL;DR: The new bound check in fast_forward_trips() compares only the period's
two ends, so a bound that changes mid-period may still be skipped. That could
give wrong loop-exit states and spurious verifier rejections.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -21046,18 +21046,21 @@ static int check_held_in_leftover(struct bpf_verifier_env *env,
>   * If the steps are not constant, the skip or "infinite" is a guess.
> + * If the bound moved, there is no skip. A later saved trip can have the same bound.
>   * Returns 1 if it skipped these trips.
>   */
>  static int fast_forward_trips(struct bpf_verifier_env *env, struct loop_stack_entry *entry)
>  {

[ ... ]

>  	/* the answer needs a walk over the program */
>  	if ((infinite ? entry->loop->infinite : entry->trips_left <= period) ||
> +	    (!infinite && saved->exit_threshold != entry->exit_threshold) ||
>  	    (u64)entry->trip * entry->loop->nr_insns < env->prog->len)
>  		return 0;

Is this check enough when the period is longer than one trip?  Header states
are saved at trips 0, 1, 2, 4, ..., so at trip 4 the comparison is against
trip 2 with period = 2.  Only the bound seen in the trip before the saved
header and the bound seen in the last trip are compared, and
note_trips_left() overwrites trips_left on every call.  A bound that changes
inside the period passes if the two ends match.

For example:

  i = 0; t = 0;
  do { end = t ? 100 : 50; t ^= 1; } while (++i < end);
  buf[i - 40];   /* buf has 16 bytes */

The bound alternates between 50 and 100.  At trip 4 vs trip 2,
saved->exit_threshold is 100 (from trip 1) and entry->exit_threshold is 100
(from trip 3), so the new check passes.  trips_left comes from trip 3's
jump (i = 4 vs end = 100, about 96 trips), so the skip adds
(96 - 1) / 2 * 2 = 94 to i and lands on i = 98.  The loop then leaves with
i = 99, while every real path leaves with i = 51.

buf[i - 40] then fails only on this unreal state.  The skip is not marked as
a guess, so the error counts as real and the budget of the next passes is
cut, which is the situation the commit message describes.  The new comment
"If the bound moved, there is no skip." also overstates what is checked.

Could the skip be refused if any trip of the period saw a different bound,
or could trips_left keep the tightest value over the period?  Otherwise,
should the changelog say that only the ends of the period are compared?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44956799894
--===============3778955900086664236==--
