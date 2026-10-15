Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A67391822
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091310; cv=none; b=ONIXrltAO6qIzj/00y5n26sB0mq/9yq77cg2ENcWurtY7T4XsYe8QiyWVNuTb+yjncPUqgtZP7T83z7/OBbFuGpuxES5KAHC+T7rVfxF7ZKImABByYUgpQZNhNUFoeehb2a1/RRYg2T63MlrpeXCS71HuvbRCZvjEXNXlQ/GnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091310; c=relaxed/simple;
	bh=txGnXayFUm0YGYx9Ud16aac5g7uzZJuuUuVm15hQ28Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RnYynlVujewR+PYR/mKn54wKV84vbhxiQ2QPdH434c/XA4qZa52ZJBRTlmCbhOX/SD51pFHylQELlb70dCuqVyzC5oQ/kPTFSoVvFoI+ZG1kYoi4MtEMlhZXRCBg1FgBUq3yhBEqlMKy48HDtSRKYQYiiDQNAYuSad+kTBM5VzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOnGFGwV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOnGFGwV"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-89d4030cc57so1373308b3a.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 12:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792091309; x=1792696109; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MTHO/kfxAAHk44Y8ow3xeGJ1fwd2vT0vs+4rf01XDJQ=;
        b=jOnGFGwViBHFn/0iMzcbdfFDwRCH9XsYmGbxxOKIbi1IoUQFFFa7RGdjAKO5IDFJZk
         MopXjR7RBthOIkF2LjtISWeJwy/E7SmTwY4mES59lWJysZNqcUrRAk2D9GGbVgIB7b/T
         qE3snQgxebmQBEq2d4CmFS6PKicsD+lK3tXO2wdcFoCAaT67uHFhrAByosDOwEy+cR+R
         sz0XYuV/didrMJYBNGBHK1Dw54yuf+ZyH8h3OFcmRYINlq6qg6DZkA38zMqxRJomDMOI
         css98RpvQ3aO4U/eCZOz/e/ko6vFnwLowyZckqKbgRIoysF7oUMYxccWCJKpm6EywBTO
         2b3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792091309; x=1792696109;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MTHO/kfxAAHk44Y8ow3xeGJ1fwd2vT0vs+4rf01XDJQ=;
        b=zQFTVU+YZli74/EvODiHZqHVKPkFTGO4vbEUKg/t0BSw0m+6qeW2jI3XtJ/tEz6mOj
         XKm0aDUdz4eoJRhvNMtEEal5cLeuo1siegbfsWeMPqkJqU8BR6+fE+sqi1FirnrURiQI
         Kc+ZXWaA2ssHUAogO04EsrwfaWPeCAe+FUSUZDOn73h++cJ6ed1n6rSPxlcqOPzn7KRM
         CDceccpSUhBovvWNGBHNI6uFhX/DuunKQGvmhsNjch0AR1sVByPQLxgnJz6hKCs8TXvH
         0vzRAD+5gMo7I6FNgMmCQaqf7TjYeS06o6USbxwNrtqd8c7qh9GT8wDwbuN3uTkxUHj8
         8/GA==
X-Gm-Message-State: AFq9FYLdMXfOpLa+f4CW+XdIjHT3Qt/J6+9FiJqseBnkvSrSt8tTyzES
	/dJMKwlpOZFoDU8MoOiG1J11Cd6zxKPqhWdKl+iQgIKj4yZ/F0hVMTrTSFxurQ==
X-Gm-Gg: AYBFou1QxeR8vH4ZywlWHKrSTswBVac0px8UKPWZ4Te8oXim4pTfDbaa8mANCiHojmi
	f+DRevMzJUEYaIFANvzjSLJ2HlMUBXt42lz+enYzrGg1LP3ajnXX0CU8tMFVEeWg8Gm2WO6u/+4
	qUTN/4DlqWt49Kyx/MObUyuwnC7n8AGng3LF6u4OLurPaeMzG1GhuhfeCkL/rVmR1via+e5CswL
	IAfAJv+7NwJnOWRVryXN+UgUhB3gctBx8uup2UO/tHnN+B076fj5VuWF+vV6PF5IE6JZ8p4+b02
	bU9Sb9MpTUSbZ/bdDp4iCHtd1AgLIsSNbUHu8YyGuNRouG/xqcHkjsUEN6EYg75iBcM4t4PRI43
	xZrDPYx+FG5zODITxGynd76Q3Rb6eCzbrPJmtIV9VQrk0LdkalUpOBhXddPxFMtypefM748VSfd
	3/rBq6w0PGGqPl+su68Hce1m9SmhN/X4vU9bkDEnMMvRDMXjtM8AnlXw7lQO4QYJwukyXzaRInf
	11GtupL5jbKCnpUHQNWPqUAGFaucdBqKuQ7MOZMfk6p9X0AV/NzcJde/HNomgfmLROnGBDbWTN0
	7r0=
X-Received: by 2002:a05:6a20:430e:b0:3e1:5481:5445 with SMTP id adf61e73a8af0-3e16bda9171mr17843458637.19.1792091308533;
        Thu, 15 Oct 2026 12:08:28 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a249f3sm24171a12.27.2026.10.15.12.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 12:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 19:08:24 +0000
Message-Id: <DM5NCJVIY5GR.3KH59CI540I82@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>, <memxor@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add JIT cBPF-related
 instruction tests
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261015171917.599025-1-daniel@iogearbox.net>
 <20261015171917.599025-2-daniel@iogearbox.net>
In-Reply-To: <20261015171917.599025-2-daniel@iogearbox.net>

On Thu Oct 15, 2026 at 5:19 PM UTC, Daniel Borkmann wrote:
> The classic BPF cases of the removed test_bpf module ran their programs
> on a hand-built skb. Run them as socket filters instead via jit_insns_cbp=
f
> test suite. This covers all previous test_bpf cases as well as a few corn=
er
> cases beyond that.
>
>   # LDLIBS=3D-static PKG_CONFIG=3D'pkg-config --static' ./vmtest.sh -- ./=
test_progs -t jit_insns_cbpf
>   [...]
>   #193/1   jit_insns_cbpf/classic:OK
>   #193/2   jit_insns_cbpf/checker:OK
>   #193/3   jit_insns_cbpf/frags:OK
>   #193/4   jit_insns_cbpf/packets:OK
>   #193/5   jit_insns_cbpf/blinded:OK
>   #193     jit_insns_cbpf:OK
>   Summary: 1/5 PASSED, 0 SKIPPED, 0/0 FAILED
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  [ Small fyi, the gso related tests I pushed here for net-next
>    https://lore.kernel.org/netdev/20261015151033.591439-1-daniel@iogearbo=
x.net/
>    thus this concludes all of old test_bpf. ]
>
>  .../selftests/bpf/prog_tests/jit_insns_cbpf.c | 2620 +++++++++++++++++
>  1 file changed, 2620 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/jit_insns_cbpf=
.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns_cbpf.c b/to=
ols/testing/selftests/bpf/prog_tests/jit_insns_cbpf.c
> new file mode 100644
> index 000000000000..5471c06605fe
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/jit_insns_cbpf.c
> @@ -0,0 +1,2620 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Isovalent */
> +/*
> + * The classic BPF cases of the former test_bpf module, run as socket
> + * filters: the data cases on an AF_UNIX datagram pair, which takes any
> + * length down to zero and puts the tail of a long datagram into page
> + * frags, the cases reading the link layer or the metadata of a packet o=
n
> + * a veth pair in their own netns. The return of a filter decides over t=
he
> + * packet, zero drops it and any other value truncates it to that length=
,
> + * so the returns of a program get rewritten: the expected result stays,
> + * any other constant becomes zero and a returned accumulator is compare=
d
> + * at the end, so that a wrong result shows as a dropped packet.
> + */
> +#include <test_progs.h>
> +#include <poll.h>
> +#include <sys/ioctl.h>
> +#include <linux/filter.h>
> +
> +#include "network_helpers.h"
> +#include "sysctl_helpers.h"
> +
> +#define MAX_K		0xffffffff
> +#define SKB_TYPE	PACKET_OTHERHOST	/* the frames go to a foreign MAC */
> +#define SKB_MARK	0x1234aaaa		/* the mark of the sending socket */
> +#define SKB_VLAN_TCI	0xffff
> +#define SKB_VLAN_PRESENT 1
> +#define SKB_DEV_IFINDEX	0			/* that of the receiving veth */
> +#define SKB_DEV_TYPE	1			/* ARPHRD_ETHER, that of a veth */
> +/*
> + * A datagram of four pages splits into three pages of head and one page=
 of
> + * frag data: what exceeds SKB_MAX_ALLOC, four pages less the shared inf=
o,
> + * goes into frags, rounded up to a page. The table cases take 4K pages,=
 a
> + * larger page keeps their datagram linear; the sweep goes by the page s=
ize.
> + */
> +#define FRAG_OFF	(3 * 4096)		/* the frag data starts here */
> +#define SWEEP_SPAN	16			/* offsets swept either side of it */
> +#define NETNS		"jit_insns_cbpf"
> +
> +static int page_size;
> +static int dgram_max;				/* four pages */
> +
> +enum {
> +	CB_FAIL		=3D 1,	/* the attach has to fail */
> +	CB_PKT		=3D 2,	/* needs the link layer or the metadata of a packet */
> +	CB_VLAN		=3D 4,	/* a tagged frame, the stack pulls the tag out */
> +	CB_FRAG		=3D 8,	/* the length is the head, the frag data goes at its en=
d */
> +	CB_IFINDEX	=3D 16,	/* the result is the ifindex of the receiving veth *=
/
> +	CB_DSTMAC	=3D 32,	/* the frame goes to the MAC of the receiving veth */
> +	CB_NOBLIND	=3D 64,	/* blinding grows the converted jump past 16 bits */
> +	CB_RAW		=3D 128,	/* the returns stay, the kept length shows the result =
*/
> +};
> +
> +struct cbpf_run {
> +	int len;
> +	__u32 result;
> +};
> +
> +struct cbpf_case {
> +	const char *descr;
> +	const struct sock_filter *insns;
> +	int cnt;
> +	int (*fill)(struct sock_filter *insns);
> +	const __u8 *data;
> +	int data_len;
> +	const __u8 *frag;
> +	int frag_len;
> +	const struct cbpf_run *runs;
> +	int nr_runs;
> +	unsigned int flags;
> +};
> +
> +#define INSNS(...)							\
> +	(const struct sock_filter[]){ __VA_ARGS__ },			\
> +	.cnt =3D ARRAY_SIZE(((const struct sock_filter[]){ __VA_ARGS__ }))
> +#define DATA(...)							\
> +	(const __u8[]){ __VA_ARGS__ },					\
> +	.data_len =3D sizeof((const __u8[]){ __VA_ARGS__ })
> +#define FRAG(...)							\
> +	(const __u8[]){ __VA_ARGS__ },					\
> +	.frag_len =3D sizeof((const __u8[]){ __VA_ARGS__ })
> +#define RUNS(...)							\
> +	(const struct cbpf_run[]){ __VA_ARGS__ },			\
> +	.nr_runs =3D ARRAY_SIZE(((const struct cbpf_run[]){ __VA_ARGS__ }))
> +
> +/* The uapi forms are initializers, these are values */
> +#define STMT(code, k)		((struct sock_filter)BPF_STMT(code, k))
> +#define JUMP(code, k, jt, jf)	((struct sock_filter)BPF_JUMP(code, k, jt,=
 jf))
> +
> +/* Jumps with gaps in between, the former __bpf_fill_ja() */
> +static int fill_ja(struct sock_filter *insns, int len, int plen)
> +{
> +	int rlen =3D (len % plen) - 1, i, j;
> +
> +	for (i =3D 0; i + plen < len; i +=3D plen)
> +		for (j =3D 0; j < plen; j++)
> +			insns[i + j] =3D JUMP(BPF_JMP | BPF_JA, plen - 1 - j, 0, 0);
> +	for (j =3D 0; j < rlen; j++)
> +		insns[i + j] =3D JUMP(BPF_JMP | BPF_JA, rlen - 1 - j, 0, 0);
> +	insns[len - 1] =3D STMT(BPF_RET | BPF_K, 0xababcbac);
> +	return len;
> +}
> +
> +static int fill_ja_short(struct sock_filter *insns)
> +{
> +	return fill_ja(insns, 12, 9);
> +}
> +
> +static int fill_ja_long(struct sock_filter *insns)
> +{
> +	return fill_ja(insns, BPF_MAXINSNS, 68);
> +}
> +
> +static int fill_too_many(struct sock_filter *insns)
> +{
> +	int i;
> +
> +	for (i =3D 0; i <=3D BPF_MAXINSNS; i++)
> +		insns[i] =3D STMT(BPF_RET | BPF_K, 0xfefefefe);
> +	return BPF_MAXINSNS + 1;
> +}
> +
> +/*
> + * A jump over MSH loads, each of which becomes 18 instructions: the
> + * converted offset has to fit 16 bits, which 1820 of them do.
> + */
> +static int fill_jump_over_msh(struct sock_filter *insns, int nr)
> +{
> +	int i;
> +
> +	insns[0] =3D JUMP(BPF_JMP | BPF_JA, nr, 0, 0);
> +	for (i =3D 1; i <=3D nr; i++)
> +		insns[i] =3D STMT(BPF_LDX | BPF_B | BPF_MSH, 0);
> +	insns[nr + 1] =3D STMT(BPF_RET | BPF_K, 0xabababab);
> +	return nr + 2;
> +}
> +
> +static int fill_jump_over_all_msh(struct sock_filter *insns)
> +{
> +	return fill_jump_over_msh(insns, BPF_MAXINSNS - 2);
> +}
> +
> +static int fill_jump_over_1821_msh(struct sock_filter *insns)
> +{
> +	return fill_jump_over_msh(insns, 1821);
> +}
> +
> +static int fill_jump_over_1820_msh(struct sock_filter *insns)
> +{
> +	return fill_jump_over_msh(insns, 1820);
> +}
> +
> +static int fill_empty(struct sock_filter *insns)
> +{
> +	return 0;
> +}
> +
> +/* A conditional jump past 32K converted instructions */
> +static int fill_late_jump(struct sock_filter *insns)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < 2000; i++)
> +		insns[i] =3D STMT(BPF_LDX | BPF_B | BPF_MSH, 0);
> +	insns[2000] =3D STMT(BPF_LD | BPF_IMM, 1);
> +	insns[2001] =3D JUMP(BPF_JMP | BPF_JEQ | BPF_K, 1, 0, 1);
> +	insns[2002] =3D STMT(BPF_RET | BPF_K, 1);
> +	insns[2003] =3D STMT(BPF_RET | BPF_K, 2);
> +	return 2004;
> +}
> +
> +/* A conditional jump over 254 loads, which expand to 12 instructions ea=
ch */
> +static int fill_jump_over_ld_abs(struct sock_filter *insns, bool taken)
> +{
> +	int i;
> +
> +	insns[0] =3D STMT(BPF_LD | BPF_B | BPF_ABS, 0);
> +	insns[1] =3D JUMP(BPF_JMP | BPF_JEQ | BPF_K, 1, taken ? 255 : 0, taken =
? 0 : 255);
> +	for (i =3D 2; i < 256; i++)
> +		insns[i] =3D STMT(BPF_LD | BPF_B | BPF_ABS, 0);
> +	insns[256] =3D STMT(BPF_RET | BPF_K, 2);
> +	insns[257] =3D STMT(BPF_RET | BPF_K, 3);
> +	return 258;
> +}
> +
> +static int fill_jt_over_ld_abs(struct sock_filter *insns)
> +{
> +	return fill_jump_over_ld_abs(insns, true);
> +}
> +
> +static int fill_jf_over_ld_abs(struct sock_filter *insns)
> +{
> +	return fill_jump_over_ld_abs(insns, false);
> +}
> +
> +/* The result is small enough for the kept length to show it as is */
> +static int fill_all_msh(struct sock_filter *insns)
> +{
> +	int len =3D BPF_MAXINSNS, i;
> +
> +	for (i =3D 0; i < len - 3; i++)
> +		insns[i] =3D STMT(BPF_LDX | BPF_B | BPF_MSH, 0);
> +	insns[len - 3] =3D STMT(BPF_LD | BPF_IMM, 0x2a);
> +	insns[len - 2] =3D STMT(BPF_ALU | BPF_XOR | BPF_X, 0);
> +	insns[len - 1] =3D STMT(BPF_RET | BPF_A, 0);
> +	return len;
> +}
> +
> +static int fill_ld_abs_cpu(struct sock_filter *insns)
> +{
> +	int len =3D BPF_MAXINSNS, i;
> +
> +	for (i =3D 0; i < len - 1; i +=3D 2) {
> +		insns[i] =3D STMT(BPF_LD | BPF_B | BPF_ABS, 0);
> +		insns[i + 1] =3D STMT(BPF_LD | BPF_W | BPF_ABS, SKF_AD_OFF + SKF_AD_CP=
U);
> +	}
> +	insns[len - 1] =3D STMT(BPF_RET | BPF_K, 0xbee);
> +	return len;
> +}
> +
> +static const struct cbpf_case cases[] =3D {
> +	{
> +		.descr =3D "TAX",
> +		.insns =3D INSNS(
> +			BPF_STMT(BPF_LD | BPF_IMM, 1),
> +			BPF_STMT(BPF_MISC | BPF_TAX, 0),
> +			BPF_STMT(BPF_LD | BPF_IMM, 2),
> +			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
> +			BPF_STMT(BPF_ALU | BPF_NEG, 0), /* A =3D=3D -3 */
> +			BPF_STMT(BPF_MISC | BPF_TAX, 0),
> +			BPF_STMT(BPF_LD | BPF_LEN, 0),
> +			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
> +			BPF_STMT(BPF_MISC | BPF_TAX, 0), /* X =3D=3D len - 3 */
> +			BPF_STMT(BPF_LD | BPF_B | BPF_IND, 1),
> +			BPF_STMT(BPF_RET | BPF_A, 0)
> +		),
> +		.data =3D DATA(10, 20, 30, 40, 50),
> +		.runs =3D RUNS({ 2, 10 }, { 3, 20 }, { 4, 30 }),
> +	},
> +	{
> +		.descr =3D "TXA",
> +		.insns =3D INSNS(
> +			BPF_STMT(BPF_LDX | BPF_LEN, 0),
> +			BPF_STMT(BPF_MISC | BPF_TXA, 0),
> +			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
> +			BPF_STMT(BPF_RET | BPF_A, 0) /* A =3D=3D len * 2 */
> +		),
> +		.data =3D DATA(10, 20, 30, 40, 50),
> +		.runs =3D RUNS({ 1, 2 }, { 3, 6 }, { 4, 8 }),
> +	},

I don't like it. It just copies old test_lib.ko into test_progs.

I'd prefer to keep cbpf untested. It's not like anyone is working on it.

pw-bot: cr
