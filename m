Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C840737E2E9
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201061; cv=none; b=a8wUw8ADZ2Z5hzYB2AWbG5P0GN1ThkjSGRRphYh3DkziuwSg4lNlAGD79W2pKVIc14Ohz50ZACg4+KvT2g7JVUMO7RE5P0/fOpqLefvxK05TE/2AgNWp2ykdcFAeItig2KQdzfELwA71ha66WJ7wmAYhaT3bwL+s1RvRPWGR1z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201061; c=relaxed/simple;
	bh=9DKb6xHLnfREgdxRPCJXHCTtQtScsj8XRblu2n1k1VI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MHHjAtNXTflES7yxxpaxwCBhRu+OrSgvwmUr3vQgB5LiJWsSNlfYGiR7nGinKvzq3592tZWrsBqA/hgdwnYox5fgFXsVqtJlq9zHrMqIyZEBbxfH/yC7BF+V+uR+I7wGqr1oqHuoRKj/3OwWi/9LIkSl/RQX64mTv18+mIVOSdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1Mhpfg/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1Mhpfg/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F73C19425;
	Tue, 14 Apr 2026 21:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776201061;
	bh=9DKb6xHLnfREgdxRPCJXHCTtQtScsj8XRblu2n1k1VI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=n1Mhpfg/d1zcF4Fo4QLuDuzgLtQ7+1jmsecC3KhIGXPwluCS/Qw9RIzQZnvwsuhAg
	 /diYXLvG+7FOGeIvWFPrVOareugW3FNLsltcmyE+EnbupkIBw6oR94RqHQY1IrnmaB
	 vmDcneAjLEApaaJELqqWt/1oyYrvEiXg8aidzVrIOPYPUU9Ya3SCUW26GqH4g5Yl4s
	 wqaKuGzkQJ+ZDYtT5Cu8weQ81xyWOOM3ijog7QDWtBsSCQHCRrDXQwJZe0KIbc2iSY
	 3Ojs2ySO6kIqijD9mgNVMDYqs7MDBKd/7IdZcHrN3FMM7E6ozC7PY26zYVz6k/yTS4
	 3xyVu5H+KTVLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/6] bpf: Extend BTF UAPI vlen, kinds to use
 unused bits
Reply-To: sashiko@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260414195019.684531-2-alan.maguire@oracle.com>
References: <20260414195019.684531-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 21:11:00 +0000
Message-Id: <20260414211101.59F73C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] The `env_stack_set_next_member()` helper takes a `u16` argument, w=
hich truncates the new 24-bit BTF `vlen` and causes an O(N^2) infinite-loop=
-like CPU lockup (Denial of Service).
- [Medium] UAPI Source Breakage: Converting `BTF_MAX_*` macros to `enum btf=
_max` removes preprocessor macros, breaking existing userspace compilation.
--

commit d88c0688f1be53ae1871dacf198a4a18b2e56ae0
Author: Alan Maguire <alan.maguire@oracle.com>

bpf: Extend BTF UAPI vlen, kinds to use unused bits

This commit expands the BTF maximum vlen from 16 bits to 24 bits, allowing
up to 16 million members. It also extends the BTF kind encoding from 5 to 7
bits, and converts the BTF_MAX_* constants to an enum to expose them in
kernel BTF.

Link: https://lore.kernel.org/bpf/CAEf4BzZx=3DX6vGqcA8SPU6D+v6k+TR=3DZewebX=
MuXtpmML058piw@mail.gmail.com/

> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index 638615ebddc22..618167cab4e61 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -33,20 +33,22 @@ struct btf_header {
>  	__u32	layout_len;	/* length of layout section	*/
>  };
> =20
> -/* Max # of type identifier */
> -#define BTF_MAX_TYPE	0x000fffff
> -/* Max offset into the string section */
> -#define BTF_MAX_NAME_OFFSET	0x00ffffff
> -/* Max # of struct/union/enum members or func args */
> -#define BTF_MAX_VLEN	0xffff
> +enum btf_max {
> +	/* Max possible kind */
> +	BTF_MAX_KIND =3D		0x0000007f,
> +	/* Max # of type identifier */
> +	BTF_MAX_TYPE =3D		0x000fffff,
> +	/* Max offset into the string section */
> +	BTF_MAX_NAME_OFFSET =3D	0x00ffffff,
> +	/* Max # of struct/union/enum members or func args */
> +	BTF_MAX_VLEN =3D		0x00ffffff,
> +};

Could replacing these #define macros with an enum break existing userspace
applications?

Programs using #ifdef BTF_MAX_VLEN or evaluating #if BTF_MAX_VLEN =3D=3D ...
for conditional compilation will fail to build without the preprocessor
macros.

Would it be better to redefine the macros alongside the enums=20
(e.g., #define BTF_MAX_VLEN BTF_MAX_VLEN) to maintain UAPI backward
compatibility while still exposing the constants to BTF?

[ ... ]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d785812076..1663970fc1bf6 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -289,7 +288,7 @@ enum verifier_phase {
>  struct resolve_vertex {
>  	const struct btf_type *t;
>  	u32 type_id;
> -	u16 next_member;
> +	u32 next_member;
>  };

Does the env_stack_set_next_member() helper also need its next_member
argument updated to u32?

Looking at env_stack_set_next_member() in kernel/bpf/btf.c:

static void env_stack_set_next_member(struct btf_verifier_env *env,
				      u16 next_member)
{
	env->stack[env->top_stack - 1].next_member =3D next_member;
}

Since the argument is still u16, won't this silently truncate the i + 1
index for any struct or datasec member beyond 65,535?

If this happens, when the verifier resumes resolution of the struct, could
it restart from the truncated index and redundantly iterate over
already-resolved members? With a very large number of members, could this
cause excessive CPU usage or soft lockups?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414195019.6845=
31-1-alan.maguire@oracle.com?part=3D1
