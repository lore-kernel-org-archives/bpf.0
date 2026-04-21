Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3004537FF6F
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781475; cv=none; b=sAr0bZyBqVL3oyKv61OcZjoqDg9quLxfhQ/nyYVzkqv73DY3E/lDwtiB/2bEogaGTfLvU8wz7n5HsuvF9w7tTAh7H+KU77u4eC+c0BGu4wi5OpFhWpJbqzJPsCD5AyHPx6qy43r0WK+JS0Uhv9MIy0xgCN2/xQrKzI2U+VIXEsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781475; c=relaxed/simple;
	bh=lvbn1S2c3s+5nSDyDbDX+prSwOAl34WikutrledB5xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fu5VsvspABd0c1ElSfXMZQESBqzz/ZMCSD+lq4BFsKJWBHM1eY1IHq60A3bDkszO2zxXhjI3KdXXoHzEvyUGii5Vu+ISTHJJR6I2hBbyBnribif1yCtizLUXIGgYIqGBrPdQqrw+8GJYdKrLVJvufuGQ0FCttnpNNkTQsgsRVOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V9irKVZ2; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V9irKVZ2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776781471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqPv5uv3CSNT8PLlCD32zVcEKZGE1q0UizQQG3FSDbY=;
	b=V9irKVZ2HAKzvwQTx7r2yUE+Baf4CBol8Ik9FTcwfNEFk8duNeEo+tnJqPs4z94CG9kyBx
	7j838QFbQWztwa8a0mOVvSWFjQsiH6ezRvMfOYRvVSf4NqtP06t8T3lPP51vtsW3z4J4q2
	PbpUpJRQL6HZVHDlsZfEpu+6yKDEfsA=
From: Leon Hwang <leon.hwang@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>,
	bot+bpf-ci@kernel.org,
	bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>,
	Eduard <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	kernel-patches-bot@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Chris Mason <clm@meta.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Introduce global percpu data
Date: Tue, 21 Apr 2026 22:13:14 +0800
Message-ID: <20260421141326.38597-1-leon.hwang@linux.dev>
In-Reply-To: <CAADnVQKEkMjmARsWMvs6SP76nEdCzBYSffSFSNE-Do=MaXMv3A@mail.gmail.com>
References: <20260414132421.63409-3-leon.hwang@linux.dev>  <72dbcacc4cf2e76dc9de3c045e2fe1f3454d8880197b0db92c7d994ca82dcab0@mail.kernel.org>  <fef2c9a0-c609-49f4-a165-890aaecfbfd8@linux.dev>  <yujp3deu4uko2xkr4dghofpvhrni6szmd7wlozehtzndvhasrl@f2xjf4egi5fd>  <3556a456-70d3-45e7-affa-355107bac30e@linux.dev>  <d0059a19-ab24-4e9c-ac54-dafc932317e9@linux.dev>  <CAADnVQJ0o38xXn6E5ub7kWyoZPiaevr9mwDNxv0GbxyguVTKUg@mail.gmail.com>  <20260420052459.85772-1-leon.hwang@linux.dev>  <DHY2JXM90466.13PVYC6ITVFKS@gmail.com>  <20260421014255.210566-1-leon.hwang@linux.dev>  <CAADnVQKEkMjmARsWMvs6SP76nEdCzBYSffSFSNE-Do=MaXMv3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Mon, 20 Apr 2026 18:59:39 -0700, Alexei Starovoitov <alexei.starovoitov@=
gmail.com> wrote:=0D
> On Mon, Apr 20, 2026 at 6:43=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev>=
 wrote:=0D
>>=0D
>> On Mon, 20 Apr 2026 07:58:06 -0700, "Alexei Starovoitov" <alexei.starovo=
itov@gmail.com> wrote:=0D
>>> On Sun Apr 19, 2026 at 10:24 PM PDT, Leon Hwang wrote:=0D
>>>>=0D
>>>> int xdp_prog(struct xdp_md * ctx):=0D
>>>> ; cnt++;=0D
>>>> 0: (18) r6 =3D map[id:28][0]+0=0D
>>>> 2: (bf) r6 =3D &(void __percpu *)(r6)=0D
>>>=0D
>>> well. that insn was inserted by the verifier and it shows up in xlated.=
=0D
>>> That was expected.=0D
>>> The point about 'bogus xlated' was about offset translation.=0D
>>> map_direct_value_meta() should recover proper insns[i + 1].imm =3D off;=
=0D
>>> In your example it's zero, so not an interesting test.=0D
>>>=0D
>>=0D
>> The original insns[i + 1] wasn't broken. See the key change of this=0D
>> patch.=0D
>=0D
> You're missing the point insns[i + 1].imm =3D off is how=0D
> off returned from map_direct_value_meta() is used in updating _this_=0D
> ldimm64 insn.=0D
=0D
After looking into bpf_insn_prepare_dump(), agreed with=0D
"not an interesting test".=0D
=0D
Then, updated the selftest with non-zero offset. And updated=0D
disasm_helpers.c::disasm_insn() to dump such ldimm64 insn as map info by=0D
the way of bpftool/xlated_dumper.c::print_imm().=0D
=0D
+static volatile const char fmt2[] SEC(".percpu.fmt") =3D "data %d\n";=0D
+=0D
+SEC("?kprobe")=0D
+__success=0D
+__xlated("r{{[0-9]+}} =3D map[id:{{[0-9]+}}][0]+9")=0D
+__xlated("r{{[0-9]+}} =3D &(void __percpu *)(r{{[0-9]+}})")=0D
+__xlated("r{{[0-9]+}} =3D *(u8 *)(r{{[0-9]+}} +4)")=0D
+int verifier_percpu_read(void *ctx)=0D
+{=0D
+	char c =3D fmt2[4];=0D
+=0D
+	return c =3D=3D ' ';=0D
+}=0D
=0D
It would verify the following xlated insns.=0D
=0D
XLATED:=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
0: r1 =3D map[id:7][0]+9=0D
2: r1 =3D &(void __percpu *)(r1)=0D
3: r1 =3D *(u8 *)(r1 +4)=0D
4: w0 =3D 1=0D
5: if w1 =3D=3D 0x20 goto pc+1=0D
6: w0 =3D 0=0D
7: exit=0D
=0D
The selftest looks better now.=0D
=0D
Thanks,=0D
Leon=0D
