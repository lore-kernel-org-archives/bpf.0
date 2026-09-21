Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966912E266C
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027174; cv=none; b=au7aVVd/ejn9EC/we4Uh9Z7IzBpTjmojFI+ynlcuUlUAUoMTzUmk+yYQqZXTlqo3TjSVKy011IVn+ve0TIibvAI5z6rST6nWiANHx1tl5ck40XhKWXJsU9/Y57D2ea5Q6gcb/gs7wsXfcaqgfRoufMc5Kurxf82gjYUZTpDn7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027174; c=relaxed/simple;
	bh=Lpsj2AIrNn5OYLVGgW/c8Mb25nQRGTHDlg/fM9u1Xb0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dX19rqdQtV7SUmPFcESQMq7oUvrPy3VTOixkk+NVyHBzv26LUG7iLXCiugTZbdjlF6AJQfYjGMuDp3UOo/18DAQb2VpfOik5sM4RetOJrklANB6pYl+yUPHW0vA7Zcmsh8qMehfETJDNvvT8w25bhMyEc657Hh6HFJVrfGZbYVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qkUwh6zg; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkUwh6zg"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccafb752so2887116a91.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790027173; x=1790631973; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=92hRYVcexh6+JTkiDvLTeHtBfBKhH+HBsj8HKf7XgwY=;
        b=qkUwh6zg7Pp2BSVmfuMUv4bWWgxqneHz79qGw56dX2AFbAiIFzFwXnjPgTrAYGodLZ
         qAbYKr3u3uAaNsyin81zmuzML5tIZ4UdYdd0wuhb4oJTvWeW+GOhjd0/naNBoxMIQN20
         ajLeYAWM2lNkyr0wKKTYeUPW82E8Vv9Bh0NXD7k2pUOyqIyYuk/K04BCzxVzYUjp17Ee
         StgNY3HRHDgZSMuE1XNirQBmOkBWDupjQ89Vu2dG20JjDR5/ys9wswO7QOrjCyWM3/Iv
         2MpGOBzQIwWX+1APz3vJIaF/LLP0/3bexb0JE41665oV4NJ8xLxQuaf2e1UWs+vtiL7f
         aTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790027173; x=1790631973;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=92hRYVcexh6+JTkiDvLTeHtBfBKhH+HBsj8HKf7XgwY=;
        b=VRFXaSr2nOuD/OX0AgHwGROI73srNeNJ7FaKwCkMkQZMKGEybe84t0ZW228EgnXxta
         kn00/exPTlcSsf1FPnl0OoAseu0PDuIcU1VJFeI987Ql1SXYlSvZarNQaOvDw6k2FGuu
         fmG//RsJWQZpe91aL0pGWTKuXZARPkGT0pSWkfQ/EJdodUaPUVjxkFyoot8DhTJSQkqF
         fZzxaZ/s1V+juKoHMUsVFff4KDWu+B5JZqUs5b8JxC1RfxPWKx7B4Tp7Rr63MQX34L/r
         rqnlBKb/igt2BiXqPsv7F0mp7jTLRl3jVd1QNIpHwOvGXJpKhdatnMzn93gcKPyAyvBd
         YpTw==
X-Forwarded-Encrypted: i=1; AKwUvByxa6AvIRUDawYYAE1EVyqFABUZHd4aZgIZlO3P/mOAy3DgZG9sZp0duyDDoBnScJlzJEA=@vger.kernel.org
X-Gm-Message-State: AFuF++nerxt+PgM13EAhBd7Phhjd/Q0SMl92N7mX0bG7IZdtfm58gPel
	CXg8FuHSqDGC7vrqZJrLVne14z3ZNXbRjQFON96ZTLmcbNeT1rK2iXiI
X-Gm-Gg: AYBFou0KBbu98TNHuYq5sxdi4zgujH4bZrAQcLJtmA/wuKZKIVwQzYkS0zIfEvrUPHl
	AV1ifh92T6FDAiSVpnw0yfNO+hbtObN54CmbSM7fo3uD5q2m2NlOiAAI0yxo/+ls7dt37wUH+RN
	/8pMBv4jDeo3XEnbeciJCDuMXPUcSSyPTm4fxi9XOpXVOEyDTaGWXCMfi5efCujCAqmIzoNSKZJ
	J0ARVVIKEmKu1iAvoSg5Yxfg4BfxUMVbIEjnTlG/WaCMrNAJ7pM9THX75v5WvMVMSLJupU61Keb
	xaE3aMKene/UfCcdhhadn4XEo9nbBmNnICti875RfdfcWp77P+vNV56UK48rCrvp8P4+fpqMDiE
	dgpORIzKdyNHRHHk9p/N3PjQTUwQiq3qgfvzsCVpmB9JUYqulNBiD2yOSm07j75zBlqjBHIjbS1
	A7b4/iMqdZe95sozL2NfBYGoQhtVTrLpOqUFS9mSy/CM/5UMU3VtPmnUeWzHqU5bkfWt3oHJZHm
	Hi10uU6gT19OfSmnxIF5AbOUH7CRGPIqEiU9eICma4qm7sSguABi96E5w==
X-Received: by 2002:a17:902:ce0c:b0:2df:336b:9c2a with SMTP id d9443c01a7336-2df336b9c5bmr93989305ad.70.1790027172483;
        Mon, 21 Sep 2026 14:46:12 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9de9:26b9:a969:69d7? ([2620:10d:c090:500::5:f95e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e5ec6ea45sm756396eec.30.2026.09.21.14.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:46:12 -0700 (PDT)
Message-ID: <f03d6246dca7a772e44bc31c98e7950d64ee55d3.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 09/11] bpftool: Add ability to dump
 LOC_PARAM, LOC_PROTO and LOCSEC
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 andrii@kernel.org, 	jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev, 
	song@kernel.org, qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
 puranjay@kernel.org, 	yatsenko@meta.com
Date: Mon, 21 Sep 2026 14:46:09 -0700
In-Reply-To: <53e01dce-efdc-4e8f-8510-e23cba17c429@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
	 <20260916074118.1007116-10-alan.maguire@oracle.com>
	 <a53eaf9758d1110ad7a2211b55533ffd470e083f.camel@gmail.com>
	 <53e01dce-efdc-4e8f-8510-e23cba17c429@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-21 at 19:47 +0100, Alan Maguire wrote:
> On 18/09/2026 21:51, Eduard Zingerman wrote:
> > On Wed, 2026-09-16 at 08:41 +0100, Alan Maguire wrote:
> >=20
> > ...
> >=20
> > > +static void btf_loc_param_str(const struct btf_type *t, char *str, s=
ize_t sz)
> > > +{
> > > +	const struct btf_loc_param *p;
> > > +	__u32 i =3D 0, vlen;
> > > +	__u64 value;
> > > +	bool negative =3D false;
> > > +	char regs[32] =3D {};
> > > +	char num[32] =3D {};
> > > +	const char *op =3D "";
> > > +
> > > +	if (!t || !btf_is_loc_param(t)) {
> > > +		snprintf(str, sz, "<invalid>");
> > > +		return;
> > > +	}
> > > +
> > > +	p =3D btf_loc_param(t);
> > > +	vlen =3D btf_vlen(t);
> > > +
> > > +	if (p->flags & BTF_LOC_PARAM_REG) {
> > > +		__u32 nregs =3D (p->flags =3D=3D BTF_LOC_PARAM_REG) ? vlen : 1;
> > > +
> > > +		if (nregs > vlen) {
> > > +			snprintf(str, sz, "?");
> > > +			return;
> > > +		}
> > > +
> > > +		switch (nregs) {
> > > +		case 2:
> > > +			snprintf(regs, sizeof(regs), "r%u, r%u",
> > > +				 p->values[0], p->values[1]);
> >=20
> > I agree with Jiri regarding the register names. It's not a huge table,
> > e.g. [1], 20 lines for x86 ~> 100-200 lines that would not really
> > change to handle all architectures that have BPF jits.
> > And it would be very convenient for those using the tool.
> >=20
>=20
> Yeah, it's doable, it's just that it is more portable when done in
> pfunct; we can use dwfl interface to get register names [1]. With
> pfunct changes in that tree we get output that is either arch-independent
> (standalone BTF) or when combined with ELF info from vmlinux
> gives us the arch-specific register names, containing function etc.
> To see the inline site for ip_send_skb for example:
>=20
> $ pfunct --inline_sites -f ip_send_skb --elf vmlinux /sys/kernel/btf/vmli=
nux.inline
> 0xffffffff8201f241 [ip_push_pending_frames+0x31, .text +0x101f241] ip_sen=
d_skb(struct net * net [%rbx], struct sk_buff * skb [%rax])
>=20
> (above does not need DWARF at all, just BTF + ELF info, so will work with=
 a
> debuginfo-stripped vmlinux)
>=20
> So for me the tool to reach for in understanding the raw BTF is
> bpftool, whereas to apply the arch-specific transformations, locate the
> absolute addresses etc I'd use pfunct. But that's just me; I'm happy to
> go with the consensus here. Given the current library support, I think
> maintaining per-arch tables in bpftool (rather than introducing a new
> library dependency) would be the way to go if we do add it.
>=20
> Quentin, what do you think? Are per-arch tables for registers in bpftool
> ok from your side? Thanks!
>=20
> Alan
>=20
> [1] https://github.com/alan-maguire/dwarves/blob/0da899665b04f16c3f68c0b7=
36834a15e045c3c9/pfunct.c#L95

Adding dwfl as an (optional?) dependency for bpftool and reusing the
same code as [1] might be an option as well.

...
