Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C63F507
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121878; cv=none; b=kjTFHXjCRh0PklX4RJmGx5l+bIjFsZk74m4k8qb4pQPgIQljoyYbwLAgfBmGDdzuyKz0HgM+RCExwo+z+xQqb9VmsPEldV+0c+YEPqGQM5gefRg1+Mt7zVMUEHYcPJEw9woVVGOviaua6/mq4kMG6TRHefH9Tf7RBz6y8PWAcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121878; c=relaxed/simple;
	bh=Dvk1gK/4HGSrFUwEc05ECs8KgpUISKn3G3bzsMjl8s0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nh+9D6zkmXriavTHobHDZq9MTdc8gbO2at6OZxChgVBBgmMnlgtUbnsf7ihP59Htc5VLixEWLrE4+fjRn+0n6VZfsx9xytRniTDGvHgneGTn6NQyef/XPL2iPdkvoOFN1R3k+4cCSXF5Fz77C3twdWwDHirJLzyRvaG6j2UQ3vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T16ckll0; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T16ckll0"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33e456e7869so186099eec.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 17:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790121876; x=1790726676; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=euH+JkGbelQanlARI/Vc+O6eU/9FZ5zEp3RqffBE3/8=;
        b=T16ckll0rEkPwJQwqeuoOzEywJcq5IeKHaqfSUFgmyi5WuhjUq/zaqHXfDuU5n7K/b
         Vfaai7prK+RPQOiyyz6DXHpztIEOp0uob5+DvvbZNGmMUesBSWr9b3R0BMGw0EIkSXer
         h4zRInS+htbN4RHh3Bdf8k6dWzcwfk6+uirXIKkKQn1dfpJ6q8UgNc+m6/78HFhYqG16
         MDUN26ckTgHJTTsCuv05PiLnCbUrPw1z+cu1yBIfOpyim8qzy0qGq5lzSK0Deo1aN3DS
         shtMzaGHr9lVPsdEqIHaI92ITgF2Uqs7sq1mwjLRz61gnqafjfaEipGirxIE0DmT32vW
         aURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790121876; x=1790726676;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=euH+JkGbelQanlARI/Vc+O6eU/9FZ5zEp3RqffBE3/8=;
        b=uA6sbgrdHGxk4deJ+YUYaRSt2m1Hrkquk6i6I4M4HdwB5zL2G+ceaZJ7gYBLGmKg0U
         q4zB9ShIIJHjp06A4bXwOwEqAqLyDssCdXoNm557KH0BjL8VvaEKmdO9RHg6LN2vJKsa
         v+VbiWy/pDQ9GPx4UrT5tykGoNGTdupal6kHRplLm03bkKUPxCTfJjZulz7zh/DV8nCm
         8bn8vVrAsR8npYf0TRvx86LZWAM3C/O+t+F16MHJm8FDh3EiVA2c3ZLrCQw8QklA0JNk
         KD0kcAhBh1Co0xWLAnNyKFXFfvHwAMFhkVV8Km2utKXxavG3bF+Pf3uyo9/CresCeQmp
         aBUA==
X-Forwarded-Encrypted: i=1; AKwUvBwQdJz3HITjn2LgqxfCoTue3EoFajw+QE3G3w0UXbSiroD0av75g7tPiwT276/NwR7t6SI=@vger.kernel.org
X-Gm-Message-State: AFuF++m4XnmWg9l5YBVmvIKEV0oANuZmUZWOxrb+YOvjkcARZecTx7qp
	BuSU3toGAnFit/5WpMkE6+sQGxUzrPCuStDnhZQvY18Obqco1NHMPfYw
X-Gm-Gg: AYBFou0p5jmgC9iPHbYNZqLahlcCt/RZVplPM5IH9eAX7EYcsWrGjculR9JdsmhgTEV
	19l/AptvH+XePYXOsKJvBZ1qNRe1siICO59i9b7a3wTGa60kfqpxZ6h6dYH4FL6C2wXBhhUWA/s
	bJOvPLUOyVPVuINngtZ25wNDt5ZQU6vUnh65YwyWoXRxg5arQW43XkN79UCw7XN0FcEFMInN1FQ
	lCgx082oqehe74SZqpoZbWVBlVlYkfvFIF0nJ2PABAPfM8nm8rfKubrk3DYPpgqkdPU8jrLsb1E
	oM3u4WoGvBN9YUgQvJOqgHFk+ljqc6aB8oB2DZRork3HKHdGpuh14+LEBcdrUVteaN9O9bmOWna
	81swbIcYHeOPDOdk4w5F7Ry2HUXuvfK5NOdXQD7jVtvKLavKD9zG8mFuW4jjd/u7Pvp/1gELNYH
	rv9B7FRX0/PdeVHLuQeW7fd7AofkCrrjtQpougQQOFvR3CkkNIAHJwUlNew8GAD3IypA/a77ZcI
	xpjJ/EvtWDEnzwm7+DWHjg9BqAcCuwJkmZNzCCjl2GRNvQoQsTJMXhHqHcaZMF3j1Vd
X-Received: by 2002:a05:7301:18a4:b0:339:6670:b84b with SMTP id 5a478bee46e88-33e5cad3563mr917248eec.24.1790121875979;
        Tue, 22 Sep 2026 17:04:35 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:f4d5:5623:3480:5143? ([2620:10d:c090:500::7:fbb7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fe502sm1503827eec.2.2026.09.22.17.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 17:04:35 -0700 (PDT)
Message-ID: <a9c4ebe0c1a08d7025179b1ec2297a4d975cd072.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Tue, 22 Sep 2026 17:04:34 -0700
In-Reply-To: <DLM8NP9S8A4E.1YIS9HRMSR62@gmail.com>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
	 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
	 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
	 <7eba4eb055e15d5c78f463d013fa98bb21d7b494.camel@gmail.com>
	 <DLM6BVU1G0V3.29T5BPPZTZ77Z@gmail.com>
	 <37e53199dfda608de30a31fc51d22ed2b25d6d2e.camel@gmail.com>
	 <DLM8NP9S8A4E.1YIS9HRMSR62@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 23:37 +0000, Alexei Starovoitov wrote:
> On Tue Sep 22, 2026 at 11:08 PM UTC, Eduard Zingerman wrote:
> > On Tue, 2026-09-22 at 21:47 +0000, Alexei Starovoitov wrote:
> > > On Tue Sep 22, 2026 at 4:27 AM UTC, Eduard Zingerman wrote:
> > > >=20
> > > > Total size of executable sections for all Meta BPF object files use=
d
> > > > for CI veristat testing is 10Mb. Of these there are 30K non-helper
> > > > call instructions in total.
> > > > So we are talking about increase by 8 * 30K =3D 240K ~ 2.4% worst c=
ase.
> > > > Note that the instruction encoding optimized for size already heart=
s
> > > > us in src/dst registers department: we have no room for virtual
> > > > registers, which would have simplified e.g. register allocation tas=
k
> > > > for ARM64. Point being that optimizing intermediate IR for size is =
not
> > > > always a right target.
> > >=20
> > > I wasn't talking about increase in bpf ELF size,
> > > but the amount of the verifier work necessary to double the number
> > > of call insns.
> >=20
> > I don't understand what you mean by the amount of the verifier work.
> > Traced program paths would remain the same, only the encoding of the
> > information about exceptions changes.
>=20
> Any new insn requires plumbing through out.
> imo ld_imm64 encoding FD inline was a mistake.
> We should have went with relocations through out.
> Much cleaner to extend.
> Same philosophy here. Landing pad is a metadata.
> It's not a good idea to encode metadata into assembly instruction.
> bpf ISA is not a high level IR.

Here [1] is Yonghong's series repackaged by codex with the following
encoding:

  call <subprog-or-kfunc> // regular encoding
  unwind <label>          // a new instruction that must follow the call in=
struction

The amount of the verifier/libbpf code dropped from ~2K to 1K lines.

[1] https://github.com/eddyz87/bpf/tree/unwind-postfix

> > Do we have a working toolchain somewhere? I can work a few examples.
>=20
> Please send SCEV upstream asap. This is way more important
> then arguing over this bits.
