Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EE1261B9E
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790313740; cv=none; b=hJ1gD9Yn+PURHIIomgmnF6qQtp2ruHa2ce2zqct4e8MRB+yl9QJpAKloBIbicz++2wTc0J5vwEYnkEoGnp1ncsE6v8yoYBQ8O1rJdac42oUmFIrS66TEFqBXXSWKsR/e2fTNZNxtpdZC/UAeFt0fBx3URpLXDcl06PJprOPJuRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790313740; c=relaxed/simple;
	bh=BFWPwoh1PwDxBfHCKsUE/AEkdSAf3ee0+SlGgj82SAk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=tpEzI5h5YtVhCgDhVNR79Lor/EcPQ5TxyyiC5J6oB46Dk27+pHivEKhWehROECUFcblfKVqt9iKYKE5IEhFagyJDlVDDT/ryAKtpyk4Eh0qgKCqKGyf0DUh+wSMRiZlf22VYZkowpG2E763ZBi4FuG8MHexWA+EQHb/7BkLqefI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eySCS8IN; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eySCS8IN"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49e8361492fso2242055e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 22:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790313737; x=1790918537; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PdKRHG0G3Iu/yP34txRZz+hjd5OsWpA7ZmDU/TfJ31M=;
        b=eySCS8INsmxrMjCYlLX+VmALqzy9zOa9EXNComh60TsMADpFelqAbrDkbCVGQaFrC9
         sUwTNBnAYqs4V3fXmwDJUYZRXKsy6jBS2+XYOvaXS1zviwbDkyisoE+aSZRkbnuOQb6g
         joljENVb1hawEEFDdKUc3KesDxb9VGCvzHoKTk65Zpgzy1RtZNIfXyRoWqex61EdpGMW
         NrG0fpuelBD/Ebujjryar1na+iRDmYx4Ml2VOGbhAeXErnbvRmYcfxCdqa8A9lcvhKs4
         D6LhHc2xpCkN1XEkm3OsX0trON8wFP+mcXBJU0AH2LYYB/iOkiaZx7UpqFh8mwdcQFtG
         jV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790313737; x=1790918537;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PdKRHG0G3Iu/yP34txRZz+hjd5OsWpA7ZmDU/TfJ31M=;
        b=JS4ONoQnofTrvfzfr0fqV47WlWpfUTRiEqYlUDzikto/do9BAtuC9eG45M+1N+ske2
         ouum5GkMbZcj03pvroK5xVviMflWbo3nMt4Fm9g9Hh6CHhyOkZj38cGrO2ZBsHZ2xl1h
         7PtuMFKxhigcSfM+kek2PHfdyHSFHP4K532ye2fspvjCgfsPVZSz1mB7XDbaGbDfpwEe
         k0qIrj/42JlRznBwBTxVe5xdFmY8hMUqgPXdjwHYGd9DA5DbzswtfIqgXm56cKD2g14Y
         /QQJaVxmPvfz9bzUuUK08PrF/z/JH2cZlYv7oKWbWp890GSTMuhdK6OyTqYn3jHnfBaz
         7GVw==
X-Forwarded-Encrypted: i=1; AKwUvBy+yLDGDAryL6mzYpkSTWwQXCzMj220B6SnYJ8QRI5G0jMDMGTCyo+XzgDpmrxh797XQ48=@vger.kernel.org
X-Gm-Message-State: AFuF++nl5yWjtRBbCZERIU9xHPmQqJt7I4uxTcHPwvjeDwqni5eXv1Tm
	jH3KVa+UMTf5S+0+KkZdisskWNDb7/S1jw10z0OzLXJToa3zCrAE9BJ5
X-Gm-Gg: AYBFou2Bzh788NDI792RFFQtuh7bNk4k+Z8UxZjjhSZHzrPxCfXuyXOXsTMKlNkl3OL
	vGvJm7HN+OuIEjXbThb7VioUh5E7JVQ0dR+CfEJGj1j+GPqz1U+UPOiyAi6ZmuXLrk47qbnhfGt
	qBchRzIxtxKzP/LnUXIt50+/+SKn/+D8rLjqn9Hb8p9dA+7cmQ/gtQYlPBajcMCVT3o36wTyhkO
	Qi3+ei4Zveo9EgCrOw49ptaLMr56LxdM1YZ6d4fY5PX9BRymyqyAmnrBSvEHpp/elkCo4r+aXBs
	JDrPNPPyEKHP0k0sOuVm2cUqsOMTtRmQZ0sz9AVI2GyTOy0r4l3H4sAq0oxPY1g0wxDaZ7KSr72
	oLRo3qen8YERdxAfwaPKMpzIUA1oSl9BWfpW2lrBXjrokH6efifai7CCG8HA2t6ttVAn36W7Nic
	YCghLDytP8wp4OM+ZW8IcPN6fw1w9s/8jOzzjph8yLpd6VYZj8Xj9SS7pPxLps6shxzhyKLZHGg
	lMTZsNipOYhy8RoinerNRxW4NuP+2GlhpZC68plOX1wqtiEFh8RM2RwnQAqrLNBtPXa6rcqSg7R
	TnBQ0uWz8nqUTDTmBPs6m070OtO8okxVIuCY9Q==
X-Received: by 2002:a05:600c:3e06:b0:49f:f099:6f9b with SMTP id 5b1f17b1804b1-49ff0997088mr16383975e9.13.1790313736835;
        Thu, 24 Sep 2026 22:22:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff06cbd2dsm29389605e9.12.2026.09.24.22.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 22:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 07:22:15 +0200
Message-Id: <DLO59414RWGN.382APGRD4P0YG@gmail.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 6/7] bpf: Correct Program Structure
 diagnostic context
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260924092941.3174809-1-memxor@gmail.com>
 <20260924092941.3174809-7-memxor@gmail.com>
 <DLNUODSRIPTF.1MRZX3443BJ19@gmail.com>
In-Reply-To: <DLNUODSRIPTF.1MRZX3443BJ19@gmail.com>

On Thu Sep 24, 2026 at 11:05 PM CEST, Alexei Starovoitov wrote:
> On Thu Sep 24, 2026 at 9:29 AM UTC, Kumar Kartikeya Dwivedi wrote:
>> Program Structure reports have two attribution gaps. A missing jump
>> table is reported at the beginning of its subprogram rather than at
>> the gotox that needs the table, and the early subprogram-layout checks
>> run before BTF line information is installed.
>>
>> Pass the failing gotox instruction into the jump-table lookup.
>>
>> The BTF validator needs the discovered subprogram boundaries together
>> with the LD_ABS and tail-call properties collected during the layout
>> scan. Collect those properties, along with the program's callx marker,
>> with nested subprogram and instruction loops, then validate BTF before
>> reporting layout errors. This makes validated source information
>> available to the jump-boundary and fallthrough reports without changing
>> either check.
>>
>> Moving BTF validation ahead of normal instruction validation also lets
>> CO-RE see a truncated final LD_IMM64. Reject a relocation targeting
>> that instruction before bpf_core_apply() can inspect or patch its
>> missing second half.
>>
>> Link: https://lore.kernel.org/bpf/cf2f420c2b21de440a7dc51b1565c0f06d4b53=
9640ee5c03384e5d77bcfb5686@mail.kernel.org/
>> Fixes: a8f427835394 ("bpf: Report Program Structure CFG errors")
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>>  kernel/bpf/cfg.c       |  6 ++---
>>  kernel/bpf/check_btf.c | 15 +++++++++---
>>  kernel/bpf/verifier.c  | 54 +++++++++++++++++++++++++++++-------------
>>  3 files changed, 52 insertions(+), 23 deletions(-)
>>
>> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
>> index 0de2f634ef67..33b98285e802 100644
>> --- a/kernel/bpf/cfg.c
>> +++ b/kernel/bpf/cfg.c
>> @@ -288,7 +288,7 @@ static struct bpf_iarray *jt_from_map(struct bpf_map=
 *map)
>>   * combined jump table in jt->items (allocated with kvcalloc)
>>   */
>>  static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
>> -					  int subprog_start, int subprog_end)
>> +					  int insn_idx, int subprog_start, int subprog_end)
>>  {
>>  	struct bpf_iarray *jt =3D NULL;
>>  	struct bpf_map *map;
>> @@ -328,7 +328,7 @@ static struct bpf_iarray *jt_from_subprog(struct bpf=
_verifier_env *env,
>>  	if (!jt) {
>>  		verbose(env, "no jump tables found for subprog starting at %u\n", sub=
prog_start);
>>  		bpf_diag_program_structure(
>> -			env, subprog_start, "missing jump table",
>> +			env, insn_idx, "missing jump table",
>>  			"Make sure subprograms containing gotox instructions are accompanied=
 by jump tables referencing these subprograms.",
>>  			"No jump table was found for the subprogram that starts at instructi=
on %u.",
>>  			subprog_start);
>> @@ -350,7 +350,7 @@ create_jt(int t, struct bpf_verifier_env *env)
>>  	subprog =3D bpf_find_containing_subprog(env, t);
>>  	subprog_start =3D subprog->start;
>>  	subprog_end =3D (subprog + 1)->start;
>> -	jt =3D jt_from_subprog(env, subprog_start, subprog_end);
>> +	jt =3D jt_from_subprog(env, t, subprog_start, subprog_end);
>>  	if (IS_ERR(jt))
>>  		return jt;
>>
>> diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
>> index 0e8b3ccc7a5b..81f4dbfbf146 100644
>> --- a/kernel/bpf/check_btf.c
>> +++ b/kernel/bpf/check_btf.c
>> @@ -373,6 +373,8 @@ static int check_core_relo(struct bpf_verifier_env *=
env,
>>  	 * relocation record one at a time.
>>  	 */
>>  	for (i =3D 0; i < nr_core_relo; i++) {
>> +		u32 insn_idx;
>> +
>>  		/* future proofing when sizeof(bpf_core_relo) changes */
>>  		err =3D bpf_check_uarg_tail_zero(u_core_relo, expected_size, rec_size=
);
>>  		if (err) {
>> @@ -391,15 +393,22 @@ static int check_core_relo(struct bpf_verifier_env=
 *env,
>>  			break;
>>  		}
>>
>> -		if (core_relo.insn_off % 8 || core_relo.insn_off / 8 >=3D prog->len) =
{
>> +		insn_idx =3D core_relo.insn_off / 8;
>> +		if (core_relo.insn_off % 8 || insn_idx >=3D prog->len) {
>>  			verbose(env, "Invalid core_relo[%u].insn_off:%u prog->len:%u\n",
>>  				i, core_relo.insn_off, prog->len);
>>  			err =3D -EINVAL;
>>  			break;
>>  		}
>> +		if (insn_idx =3D=3D prog->len - 1 &&
>> +		    prog->insnsi[insn_idx].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW)) {
>> +			verbose(env, "Invalid core_relo[%u] targets truncated bpf_ld_imm64 i=
nsn\n",
>> +				i);
>> +			err =3D -EINVAL;
>> +			break;
>> +		}
>>
>> -		err =3D bpf_core_apply(&ctx, &core_relo, i,
>> -				     &prog->insnsi[core_relo.insn_off / 8]);
>> +		err =3D bpf_core_apply(&ctx, &core_relo, i, &prog->insnsi[insn_idx]);
>>  		if (err)
>>  			break;
>>  		bpfptr_add(&u_core_relo, rec_size);
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 1c52e7bd570d..63b32a39a0f7 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3098,6 +3098,34 @@ static int add_kfuncs(struct bpf_verifier_env *en=
v)
>>  	return 0;
>>  }
>>
>> +static void find_subprog_properties(struct bpf_verifier_env *env)
>> +{
>> +	struct bpf_subprog_info *subprog =3D env->subprog_info;
>> +	struct bpf_insn *insn =3D env->prog->insnsi;
>> +	int cur_subprog;
>> +
>> +	for (cur_subprog =3D 0; cur_subprog < env->subprog_cnt; cur_subprog++)=
 {
>> +		int i;
>> +
>> +		for (i =3D subprog[cur_subprog].start;
>> +		     i < subprog[cur_subprog + 1].start; i++) {
>> +			u8 code =3D insn[i].code;
>> +
>> +			if (code =3D=3D (BPF_JMP | BPF_CALL) &&
>> +			    insn[i].src_reg =3D=3D 0 &&
>> +			    insn[i].imm =3D=3D BPF_FUNC_tail_call) {
>> +				subprog[cur_subprog].has_tail_call =3D true;
>> +				subprog[cur_subprog].tail_call_reachable =3D true;
>> +			}
>> +			if (BPF_CLASS(code) =3D=3D BPF_LD &&
>> +			    (BPF_MODE(code) =3D=3D BPF_ABS || BPF_MODE(code) =3D=3D BPF_IND)=
)
>> +				subprog[cur_subprog].has_ld_abs =3D true;
>> +			if (bpf_is_callx(&insn[i]))
>> +				env->has_callx =3D true;
>> +		}
>> +	}
>> +}
>> +
>>  static int check_subprogs(struct bpf_verifier_env *env)
>>  {
>>  	int i, subprog_start, subprog_end, off, cur_subprog =3D 0;
>> @@ -3111,17 +3139,6 @@ static int check_subprogs(struct bpf_verifier_env=
 *env)
>>  	for (i =3D 0; i < insn_cnt; i++) {
>>  		u8 code =3D insn[i].code;
>>
>> -		if (code =3D=3D (BPF_JMP | BPF_CALL) &&
>> -		    insn[i].src_reg =3D=3D 0 &&
>> -		    insn[i].imm =3D=3D BPF_FUNC_tail_call) {
>> -			subprog[cur_subprog].has_tail_call =3D true;
>> -			subprog[cur_subprog].tail_call_reachable =3D true;
>> -		}
>> -		if (BPF_CLASS(code) =3D=3D BPF_LD &&
>> -		    (BPF_MODE(code) =3D=3D BPF_ABS || BPF_MODE(code) =3D=3D BPF_IND))
>> -			subprog[cur_subprog].has_ld_abs =3D true;
>> -		if (bpf_is_callx(&insn[i]))
>> -			env->has_callx =3D true;
>>  		if (BPF_CLASS(code) !=3D BPF_JMP && BPF_CLASS(code) !=3D BPF_JMP32)
>>  			goto next;
>>  		if (BPF_OP(code) =3D=3D BPF_CALL)
>> @@ -3143,9 +3160,10 @@ static int check_subprogs(struct bpf_verifier_env=
 *env)
>>  		}
>>  next:
>>  		if (i =3D=3D subprog_end - 1) {
>> -			/* to avoid fall-through from one subprog into another
>> +			/*
>> +			 * To avoid fall-through from one subprog into another,
>>  			 * the last insn of the subprog should be either exit
>> -			 * or unconditional jump back or bpf_throw call
>> +			 * or unconditional jump back or bpf_throw call.
>>  			 */
>>  			if (code !=3D (BPF_JMP | BPF_EXIT) &&
>>  			    code !=3D (BPF_JMP32 | BPF_JA) &&
>> @@ -22410,17 +22428,19 @@ int bpf_check(struct bpf_prog **prog, union bp=
f_attr *attr, bpfptr_t uattr,
>>  	if (ret < 0)
>>  		goto skip_full_check;
>>
>> -	/* Discover all subprograms before validating their layout and BTF. */
>> +	/* Discover all subprograms and collect the properties needed by BTF v=
alidation. */
>>  	ret =3D add_subprogs(env);
>>  	if (ret < 0)
>>  		goto skip_full_check;
>>
>> -	ret =3D check_subprogs(env);
>> +	find_subprog_properties(env);
>> +
>> +	/* Validate BTF and apply CO-RE before reporting subprogram layout err=
ors. */
>> +	ret =3D bpf_check_btf_info(env, attr, uattr);
>>  	if (ret < 0)
>>  		goto skip_full_check;
>>
>> -	/* Validate BTF against the complete subprogram layout and apply CO-RE=
. */
>> -	ret =3D bpf_check_btf_info(env, attr, uattr);
>> +	ret =3D check_subprogs(env);
>
> I think this is undoing your own fix
> commit c26e97721b172163

Only find_subprog_properties() is moving ahead to let us see func/line info=
 for
formatting messages.

I think you missed v3, that was the most recent posting. Already dropped CO=
-RE
change there.

https://lore.kernel.org/bpf/20260924170646.2366016-7-memxor@gmail.com

Should I resend last 3 commits again (or just patch 6)?
