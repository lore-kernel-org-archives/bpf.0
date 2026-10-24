Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792823928;
	b=OgfSUlXxt8mqgzTwztsGJr+xJhjWkXx2P9yJMt4MneaZT3lJLxhU00wPpFJAIpUJaFBK
	 NZfCTktjA6WLQ6NJls7MO/kRpMHEBq7jn7DUTl+MtioLu4JIodB1BnFW1vMEuHJmG6wyc
	 e8brzLa6asOcIN0l6MG6ABs/2nCiBhsXOBHpnRETfKQ8aml1odTsEBjETTTOdXaN1r/3q
	 6OTsbnKSdDwSKTh44XflbWJDFqJbtVMiehKkkHrqqADOuLIna2PMw/xKAazajuf+PlxiH
	 dvIQIqKV8ATBxxk3bl74iftkXfmaRwQ6Fd6b7Om/OGuvkKXz5cGiVRrqmvTIFBk3eJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792823928;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hHvyayL/H+H3ZN1WHdf6p0nRk1BCb+XkXk1BJp47Pr0=;
	b=XaCKpmbCEDpetHjTJOZlc49cZF3PCToeUS81RNZpff1V8I3cX0hccQBCgds1PQeWGEV/
	 gkEBVWkV4S1zkWsVIQ6/ZA+8w0muyw6eJtdcXzh+Yd8ecV2a2/bQmtSPYFr6fJgbEHRkW
	 RgyW+JLaBePN9odXtPT33MMynaXXU4b7OnFvSZf9NHNFY5GJEPk1i22hxN/+WM0dGFmbd
	 uQHDLfRe82seilYTV3TSaIsMaXSUWDoqxxZQfh/EVxG739X5CdhMiqB7wRyRUNnCbSkUN
	 h8mS+BkL3j05+cyQ2v0tfxcGkf+EgEY70Bnvk94sYnH5d/8WxXRJsPOdtTgDRIbQAKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwZOaZGJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3767606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 06:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwZOaZGJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B45E1F01825;
	Sat, 24 Oct 2026 06:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792823927;
	bh=hHvyayL/H+H3ZN1WHdf6p0nRk1BCb+XkXk1BJp47Pr0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NwZOaZGJnot8e0Xr5ayL0aJgg/0QgZD2KWVLdvHpQSsWCAC1DkAS/cMiDby0bfWuB
	 JUoOaBckLH/ndgqncduMMFtGSM6zbVk6oNSrNWX7EjdIsqgX18TiPWXkQ5ch9sXvtZ
	 txJTowUWPADXw6t242G/58PXvbwb79WSyw98ZAxxoV7IqUm5So7htsQ/pLV47sKjXH
	 rdF9WJbdvFMzMwDPPRKWujTOzJCWMFQTbgH5O9SV4YOlwcqE2OGRxk/wIQZWBNpW8b
	 c0l+AkD5Gl+z5M+LycQtSo5mVpLZwDB4Nbq8Z8c6nRbLfg5rJP68zEke7VEeFYwvgK
	 YeCcNwBTyWOmA==
Message-ID: <sashiko-outbox-183570@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpftool: fix line info in multi-function CFG dumps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zateev" <hackerowskiy@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261024062329.264086-1-hackerowskiy@gmail.com>
References: <20261024062329.264086-1-hackerowskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 06:38:46 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpftool: function-relative bpf_func_info offset in dump_xlated_f=
or_graph()
--

commit 880c182e492fbe51e0cdd7cbcdc7fcfdb2fe9c94
Author: Eduard Zateev <hackerowskiy@gmail.com>

bpftool: fix line info in multi-function CFG dumps

This commit passes the program start pointer into the CFG graph dumper so t=
hat
BTF line-info lookups and displayed instruction indices use the global
instruction offset rather than a function-relative offset, while keeping
function-info matching relative to each function. It also adds a BPF selfte=
st
for multi-function visual CFG output.

Link: https://github.com/libbpf/bpftool/issues/178

> diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
> index e3785f9a697de..65ec45469743b 100644
> --- a/tools/bpf/bpftool/cfg.c
> +++ b/tools/bpf/bpftool/cfg.c
> @@ -383,7 +383,7 @@ static void cfg_destroy(struct cfg *cfg)
> =20
>  static void
>  draw_bb_node(struct func_node *func, struct bb_node *bb, struct dump_dat=
a *dd,
> -	     bool opcodes, bool linum)
> +	     struct bpf_insn *prog_start, bool opcodes, bool linum)
>  {
>  	const char *shape;
> =20
> @@ -400,11 +400,11 @@ draw_bb_node(struct func_node *func, struct bb_node=
 *bb, struct dump_data *dd,
>  	} else if (bb->idx =3D=3D EXIT_BLOCK_INDEX) {
>  		printf("EXIT");
>  	} else {
> -		unsigned int start_idx;
> +		unsigned int start_idx =3D bb->head - func->start;
> +
>  		printf("{\\\n");
> -		start_idx =3D bb->head - func->start;
>  		dump_xlated_for_graph(dd, bb->head, bb->tail, start_idx,
> -				      opcodes, linum);
> +				      prog_start, opcodes, linum);
>  		printf("}");
>  	}
> =20

[ ... ]

> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated=
_dumper.c
> index 5579173a61e3b..847241bbe91e2 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -353,7 +353,7 @@ void dump_xlated_plain(struct dump_data *dd, void *bu=
f, unsigned int len,
>  }
> =20
>  void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *=
buf_end,
> -			   unsigned int start_idx,
> +			   unsigned int start_idx, struct bpf_insn *prog_start,
>  			   bool opcodes, bool linum)
>  {
>  	const struct bpf_insn_cbs cbs =3D {
> @@ -374,6 +374,7 @@ void dump_xlated_for_graph(struct dump_data *dd, void=
 *buf_start, void *buf_end,
> =20
>  	for (; cur <=3D insn_end; cur++) {
>  		unsigned int insn_off;
> +		unsigned int linfo_offset;
> =20
>  		if (double_insn) {
>  			double_insn =3D false;
> @@ -381,7 +382,8 @@ void dump_xlated_for_graph(struct dump_data *dd, void=
 *buf_start, void *buf_end,
>  		}
>  		double_insn =3D cur->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW);
> =20
> -		insn_off =3D (unsigned int)(cur - insn_start + start_idx);
> +		insn_off =3D (unsigned int)(cur - insn_start) + start_idx;
> +		linfo_offset =3D (unsigned int)(cur - prog_start);
>  		if (btf && record) {
>  			if (record->insn_off =3D=3D insn_off) {

[Severity: Medium]
Should struct bpf_func_info matching in dump_xlated_for_graph() also use the
global instruction offset from the start of the program rather than the
function-relative insn_off?

In the kernel verifier and in dump_xlated_plain(), record->insn_off is the
global instruction offset from the start of the whole program (0 for the ma=
in
program, and the subprogram start offset for each subprogram).

In dump_xlated_for_graph(), record is initialized to dd->func_info at the
start of each basic block:

    struct bpf_func_info *record =3D dd->func_info;
    ...
        insn_off =3D (unsigned int)(cur - insn_start) + start_idx;
        linfo_offset =3D (unsigned int)(cur - prog_start);
        if (btf && record) {
            if (record->insn_off =3D=3D insn_off) {
                btf_dumper_type_only(btf, record->type_id,
                                     func_sig,
                                     sizeof(func_sig));
                if (func_sig[0] !=3D '\0')
                    printf("; %s:\\l\\\n", func_sig);
                record =3D (void *)record + dd->finfo_rec_size;
            }
        }

Because draw_bb_node() computes start_idx as bb->head - func->start, every
subprogram's entry basic block starts at insn_off =3D=3D 0. When
dump_xlated_cfg() -> cfg_dump() -> func_output_bb_def() -> draw_bb_node() ->
dump_xlated_for_graph() runs on the second function (cluster_1), insn_off =
=3D=3D 0
matches func_info[0] (record->insn_off =3D=3D 0) and prints the first funct=
ion's
prototype at the entry of the second function.

Then record advances to func_info[1], whose record->insn_off is the global
instruction offset of the second function (for example, 2 in bpftool_cfg.c).
When the loop reaches function-relative insn_off =3D=3D 2 inside the second
function's entry block (global instruction 4), record->insn_off =3D=3D insn=
_off
matches mid-block and emits the second function's prototype before instruct=
ion
4 instead of instruction 2 (or omits it if the entry basic block is shorter
than the global offset).

If draw_bb_node() passes start_idx as bb->head - prog_start (or if
dump_xlated_for_graph() computes the global offset from prog_start and walks
dd->func_info up to that offset), wouldn't that fix the function prototype
annotations in cluster_1 as well and avoid needing both start_idx and
prog_start?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024062329.2640=
86-1-hackerowskiy@gmail.com?part=3D1
