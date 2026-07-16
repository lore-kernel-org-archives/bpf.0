Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8632BF4B
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203876; cv=none; b=bCU0XoEpOLSyd/kVJmUgC0L4eZm7nwaEkX7Xc/FbvStvx4EAL1w5t/9MeaSytwiD6wEzThn6HvzbY7b5bLAD1y+StgvmEUI7Kl8aqGPFnsPyenHT9DW47L464eQ+HzfaOL8Z7dSmVtJnjU0cwbeu0fuohqtfKmqtF6OORrXXPUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203876; c=relaxed/simple;
	bh=0/jYEiLDQhmQXkAbacNSDZFJVz5uTydZ9E0R4O+c7bM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MigRYP3CeoDjkXYtHW2oMiQO9vDZbiN9UbKIuYIfLiIZnvrc1Mbg75Ftz9K7fJ8jxl6C9suEBKa9c+XBsBWyiiac3aQf7Y88+yOT8cFlhaqxs6/4k0ltIRfqB2M4+sUUe9Fcku2suuiyyUkPM46QQ0YwyVceuXN69ng7uJASwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqjEjrpf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqjEjrpf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BBB1F000E9;
	Thu, 16 Jul 2026 12:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784203875;
	bh=egzxVvJM14fDjKdWGTzIc/OD1bHdxxB17LIB849HGmg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lqjEjrpfSUWGFVSS3k9LxaLJzUOZQ2UyYaKroPGKXs2zmMDjJoOB6QtkfIEUczlkU
	 mAqjgMbdSqq5tS7HkkDNkUHJXipHeDjFW7NsZwj8Ao/phRLA9ZSpQdH638DeeEwsgo
	 TB9iTSiyegJFqlxIH3CSp1Ii4JWldPttNovE7QOcalM3qtl7A/o10cgmDocx0Ku8ij
	 NU1DJp/GqgZUUXtKLFbhuiARyKr6J//4qm2maEhwTxO0oPEVZ6Zw8AczHEEE6WVVG+
	 yhf34W+OS7BNJP7ClS4HPoqp2oAxtgEUEi0t4c0WrBhiMHdkMTY7GDORjpz9ZGVDtI
	 nNRP47SnS65Zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/3] bpf: Reject callback subprogs invoke
 tailcall
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260716120157.835937-3-pulehui@huaweicloud.com>
References: <20260716120157.835937-1-pulehui@huaweicloud.com>
 <20260716120157.835937-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 12:11:15 +0000
Message-Id: <20260716121115.53BBB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Direct tail calls inside async and exception callbacks are no long=
er rejected, bypassing the Tail Call Counter (TCC) limit and potentially ca=
using infinite tail calls or crashes.
--

--- Patch [2]: [PATCH bpf-next v3 2/3] bpf: Reject callback subprogs invoke=
 tailcall ---
commit 99ae0587c85d574b41c654707864af3b7ff51fa8
Author: Pu Lehui <pulehui@huawei.com>

    bpf: Reject callback subprogs invoke tailcall

This commit aims to fix infinite tailcalls by rejecting tailcalls inside
all subprograms of synchronous callbacks. It also consolidates the existing
async and exception callback checks into a single unified check.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 782d939c38cdc..62d46b4c9962f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5237,10 +5237,6 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
>  		if (verifier_bug_if(sidx < 0, env, "callee not found at insn %d", next=
_insn))
>  			return -EFAULT;
>  		if (subprog[sidx].is_async_cb) {
> -			if (subprog[sidx].has_tail_call) {
> -				verifier_bug(env, "subprog has tail_call and async cb");
> -				return -EFAULT;
> -			}

[Severity: High]
Does removing this explicit check allow direct tailcalls inside async and
exception callbacks to bypass validation?

If an async or exception callback does not make any subprogram calls (acting
as a root subprogram), the local variable tail_call_reachable will remain
false, as it is only set to true when traversing into or returning from a
callee subprogram.

>  			/* async callbacks don't increase bpf prog stack size unless called d=
irectly */
>  			if (!bpf_pseudo_call(insn + i))
>  				continue;
> @@ -5281,8 +5277,8 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx,
>  	 */
>  	if (tail_call_reachable) {
>  		for (tmp =3D idx; tmp >=3D 0; tmp =3D dinfo[tmp].caller) {
> -			if (subprog[tmp].is_exception_cb) {
> -				verbose(env, "cannot tail call within exception cb\n");
> +			if (subprog[tmp].is_cb) {

Because tail_call_reachable evaluates to false for callbacks without
subprogram calls, will this unified check be completely bypassed?

Since these callbacks are invoked directly by the kernel rather than via a
BPF-to-BPF call, the Tail Call Counter register might be uninitialized. Cou=
ld
this bypass the TCC limit and lead to infinite tailcalls?

> +				verbose(env, "cannot tail call within callback\n");
>  				return -EINVAL;
>  			}
>  			if (subprog[tmp].stack_arg_cnt) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716120157.8359=
37-1-pulehui@huaweicloud.com?part=3D2
