Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600618;
	b=ywTOnp+ocY9PEap2efr7M4odfsUWpY3Ch4EURigcib2zf6YD33Ri6AhhNEvRlcKP1q78
	 nuZsc7TyLOiHyt0QkonKS7jrFLFsYd+aNlXHA4MuYw58vbJfaCa8pqgnEgzQlRyEsVd8/
	 ylZiiYx+889vSRGfdc1RU05y1g6nuUgXlABkiAfeN2QnRIFzkfGK6RCAccmSeHLguC/Jc
	 9AX0J697yiz4X0PRToxzH5/q7vVsK5LDYmIRv6m8pFHYzKn+LTe6+h1iYXqaW29DB8zqo
	 Fh7Jnw3+4l0RcVwBkFEe9HTW+J2S5cAfuOqgXJxUpIjB+dCc8SY48W78JHpWUUP5AUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600618;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=7kn8Bmo0z9NedAVtognzXOXkZQLbLtKGQdoX1gHspvM=;
	b=gMveW+PdB3Dtf+L+Y1yWJrAIf7oUvqD6stqzl5RgBl5B+RsQLLxbPqB2s+vY9HbxjU8t
	 oqlB7UhxmR1roo48H4UYnNQ3NSX8YRSCF9dHTaTxZDdwguC7VXVhiyIvZMP97YIZcf8y6
	 8PfGeAxSdZfRw+R6Igt3XrnzCbnZtcM6WtBbMG6HIt6l6xQt58L16GsUTwYkN+qVGn4tX
	 U3B1Aac2zfgHadarY+9eduZf/RLdfRRT6jtIuFJUCxAuN1hT0jLup6BjOoAfuDACxKdbH
	 DOV5SIJpXYNsnY4nzC8ozkDhhpkDKs972DmHEZuCLW1LAnFDIvhe/LOZZHCMsgMorGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HA5aJQWj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07E3606A31D;
	Wed, 21 Oct 2026 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HA5aJQWj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DFD1F000C2;
	Wed, 21 Oct 2026 16:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792600617;
	bh=7kn8Bmo0z9NedAVtognzXOXkZQLbLtKGQdoX1gHspvM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HA5aJQWjksqthGT6mmyvw3aX3UEp9t5fFCW6hnTLbG1y30X+xpXVPMelrbg1LEiCr
	 wDkwwokXYmLv5lD6wpca8pHgBLemzxjsowgc0E7b2z7baeGD0+VIJLgZOKHxqdpEkQ
	 KDFQZKAkqkma7xlUqv4Hi/ocv5PMQJhNfdo3vPffavrrfeLM4MN3V72mOgf0wsYhPg
	 dG2etJoAlAQ3cyCVslJf1tbBwYMUZKrhdbtYcx9bmC2kdZttlwyvSiyzVFd0SuGKcG
	 MSGLPsp9fZV+ZnyJ1bkBZGN+KUf4R6dXlMhj3rrYkwhXk4194ByJGXB3KFlO6vxmTj
	 tiwN5Gphdv63Q==
Content-Type: multipart/mixed; boundary="===============6773216958783884000=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20fd3dbb729bbded4888d3e852d5c613d5ca459f1489d81eeceb4b081e298687@mail.kernel.org>
In-Reply-To: <20261021152455.71524-1-leon.hwang@linux.dev>
References: <20261021152455.71524-1-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next] bpf: Pass extack to bpf_xdp_link_attach
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,hawk@kernel.org,sdf@fomichev.me,kuniyu@google.com,liuhangbin@gmail.com,mkarsten@uwaterloo.ca,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,leon.hwang@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 21 Oct 2026 16:36:56 +0000 (UTC)

--===============6773216958783884000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Pass extack to bpf_xdp_link_attach

TL;DR:
- link_create() now logs extack message even when XDP attach succeeds (e.g.
  vmxnet3 LRO), changing behaviour; success path doesn't finalize the log
- Nit: braces in column 0 in the new case block

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 87cd122d1024..26917a1ecbb2 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5944,8 +5944,14 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
>  		break;
>  #ifdef CONFIG_NET
>  	case BPF_PROG_TYPE_XDP:
> -		ret = bpf_xdp_link_attach(attr, prog, log);
> +{

This isn't a bug, but the opening and closing braces of this new block scope
sit in column 0 on lines of their own inside the function body.  Could they
follow the usual 'case X: {' form instead?

	case BPF_PROG_TYPE_XDP: {
		struct netlink_ext_ack extack = {};

		ret = bpf_xdp_link_attach(attr, prog, &extack);
		if (extack._msg)
			bpf_log(log, "%s\n", extack._msg);
		break;
	}

A '{' or '}' in column 0 inside a function body can also confuse diff hunk
headers, ctags and vim's [[ motions.

> +		struct netlink_ext_ack extack = {};
> +
> +		ret = bpf_xdp_link_attach(attr, prog, &extack);
> +		if (extack._msg)
> +			bpf_log(log, "%s\n", extack._msg);

Is it intended that this now logs extack._msg regardless of the value of
ret?

Before this patch the copy sat inside the failure branch of
bpf_xdp_link_attach():

	if (err) {
		link->dev = NULL;
		bpf_link_cleanup(&link_primer);
		if (extack._msg)
			bpf_log(log, "%s\n", extack._msg);
		goto out_put_dev;
	}

Some ndo_bpf handlers set extack on a successful install.  For example,
vmxnet3_xdp_set() does:

	if (adapter->netdev->features & NETIF_F_LRO) {
		NL_SET_ERR_MSG_MOD(extack, "LRO is not supported with XDP");
		adapter->netdev->features &= ~NETIF_F_LRO;
	}

and then installs the program and returns 0.  The path is:

__sys_bpf()
  link_create()
    bpf_xdp_link_attach()
      dev_xdp_attach_link()
        dev_xdp_attach()
          dev_xdp_install()
            vmxnet3_xdp()
              vmxnet3_xdp_set()

On that path BPF_LINK_CREATE succeeds and returns a link fd, yet
"vmxnet3: LRO is not supported with XDP\n" is now copied into the user's
log_buf by bpf_verifier_vlog() through copy_to_user().  Before this patch
nothing was written on success.

The success path is also only partly handled.  link_create() calls
bpf_log_attr_finalize() only when ret < 0:

	out:
		if (ret < 0) {
			int err = bpf_log_attr_finalize(&attr_log, log);

so on success the text lands in the user buffer, but log_true_size is never
reported and the rotating-mode buffer is never linearized by
bpf_vlog_finalize().

The commit message only talks about transferring "the error message".  If
the old behaviour is wanted, should the condition be 'if (ret < 0 &&
extack._msg)'?  If logging warnings on success is intended, should the
commit message say so, and should the success path finalize the log as well?

>  		break;
> +}
>  	case BPF_PROG_TYPE_SCHED_CLS:
>  		if (attr->link_create.attach_type == BPF_TCX_INGRESS ||
>  		    attr->link_create.attach_type == BPF_TCX_EGRESS)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39627153683
--===============6773216958783884000==--
