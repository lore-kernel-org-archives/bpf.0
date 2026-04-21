Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785C538655B
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 23:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776815107; cv=none; b=RsmNpcs3dR6BYzRzFL9PKCorLi6XbRvosDYFwfqVV04LWtfpX8Lr6y6F0cKX527BsNdxt1Xfx2l9fanGPNNTDVRCHNeEg36IbY2L4vXyA/MpD89gm4x3u+UHn94J9UzgYxjV5yKQuQ7GOES5Khx6R1y5nNUO1SlpBxnBlo87V7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776815107; c=relaxed/simple;
	bh=0hSnG3Z+WSvQsl33DJwkcHJpOoxngM6SuhlDP9Ocz/Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O+lzJvIKo973jpyP9j314PjtsMUSee1aMfZXMf8fEAZPGhlFj0UE03Oty053WmjajwyCB2UWBMXUBBeY79GgOY0HOl5ZD+/SVSGfIXFwGu6OYxdcy5WhogudDjWx8y8ko0e7FuRieC1kDT9M3dt5u2lcfjSnM7EOqnJoI4MPuwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQwsCQQh; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQwsCQQh"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so3158221a91.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776815105; x=1777419905; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5odNoHITt5sRAnmAXwNNmdyViEIYwuns4bGwcTN+64E=;
        b=TQwsCQQhrKuahXLNQfyLPLBm5JTfKNGOgQU3bmrFtRjCxbnRKhrduJCYD5nX8F8HM0
         Q793rTILgXBZ6Txpm5p6jsM1+6xr0Bx59ImM+iuazYn38wyh5han1RUvZvuiEt8e+YAm
         BuwNyKpLcDB+VxT+FrnBWwtAAgJ2XcwGVIFVE/lKfn2rlxoLhVqYHipiO1RD+XWbH4Fi
         Un0rZmVYwXmJlP9Lt/S+Rb8L8+GQQCJlB//ybFNywfv8UBHWgwJ/1WM9R9RaGg8xp4sH
         iijEUKIIPenL2Dnm+weuKiMpwIAukQgEviTaBkMQ//5JkE7xtBVGbnNZIMe5NxdBOIK2
         BOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776815105; x=1777419905;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5odNoHITt5sRAnmAXwNNmdyViEIYwuns4bGwcTN+64E=;
        b=SLbrwGYFW7S7ozV3xcXBZu++6qk3nAcx9y9QVROIoOmvPl+WK2vxsA5iCZseRJVDJr
         PPcXeTDEceQ64oc2i//gHSHGxvBkSTGnsureEMYuyA+vMQPiX1lYonAQyF7fQfCcuSMp
         LCZ7/o+hR9W7+vVtUlOg6ITUqE1RnmgLsXxnkY1RgiZ4TsBYbLjkhNwJgqAQmlpufVX/
         d3SJIqXj+Gyz57WqNzvKdlRZ9DQlyD51TjokRDQ31tkQJ5VnqsWzZONDTBCT7CCx3fB7
         WYvdgz810ijKn/iAM1JpOyG1TX4578kZXs/iLEr7Lb7LGcsnwptX7EkMpnSAvOwysvjL
         5EVw==
X-Gm-Message-State: AOJu0YztzpvNPlnQij6pdYX3iXezjRXJG11UwFodN4z5SCLU0eEgLNWn
	XOQQfBDbIzYdE58kYK57BEKNW3Ik0qh/uuJRSKMyhdfb3p6RKzLKRswalo2k7em7
X-Gm-Gg: AeBDieuK1DzHPVMxV1fQ4Dd1LlCMANNKAAf4evw/wZ5ZDkJzO/MdwLQFfBvh0zeTEhB
	km6UNacRgNhp81L1FJSY+mTv559QkOjNhGEgbxo4ircbfSGkP0rxCqrpTTdltl+I1dLtKSfWaZG
	A7+LI1yYJyNwuzrATUrMgA5DeZSVvNwwbUrfcMojJ5obU4r91FlxEq+P1BHAKswUmQFv83fPsFF
	64RDFQWNxbWZ6uzeoZuME63GYVaLfNQ3+Dkwudj6B4VGwF82ItraAqiuRKViLgLtmm8sK1HhWO3
	Cm8cxf/tdAD/yUchu0swDbzmCLyfWQCZaWOB5C0A/g3btu3MY0erdR+ynuG6BKjwJ1BEnVJyX/C
	SQC0ktyMai4YAbz3RGR8CRKKQwMYJNlgkP4gJpty+GLrk12qFkeegbvfElkhg06VSxmqSt8GIjx
	A3puP1XmIN30Ila+D3U7kQ+P2bJgqplTjSvt5Qw5ssl5Mf+CGUkIagE/2DZx1Ce3k=
X-Received: by 2002:a17:90b:5383:b0:35f:b7c1:faad with SMTP id 98e67ed59e1d1-361404a727fmr19566380a91.25.1776815105518;
        Tue, 21 Apr 2026 16:45:05 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361417748aesm14634280a91.0.2026.04.21.16.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 16:45:05 -0700 (PDT)
Message-ID: <45c4830902d26b88066f53245497104a5dac5fa0.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: replace min/max fields with
 struct cnum{32,64}
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, shung-hsi.yu@suse.com, paul.chaignon@gmail.com, 
	harishankar.vishwanathan@gmail.com
Date: Tue, 21 Apr 2026 16:45:02 -0700
In-Reply-To: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-04-21 at 03:28 -0700, Eduard Zingerman wrote:

[...]

> Verification performance measurements
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Tested on 6683 programs across four corpora: Cilium (134 programs),
> selftests (4635), sched_ext (376), and Meta internal BPF corpus
> (1540). Program verification verdicts are identical across all four
> program sets - no program changes between success and failure.
>=20
> Instruction count comparison (cnum vs signed/unsigned pair):
> - 104 programs improve, 44 regress, 6564 unchanged
> - Total saved: ~290K insns, total added: 10K insns
> - Largest improvements:
>   -26% insns in a internal network firewall program;
>   -47% insns in rusty/wd40 sched_ext schedulers.
> - Largest regression: +24% insns in one Cilium program (5062 insns
>   added).
>=20
> Raw performance data is at the bottom of the email.

I applied the fixes for bugs found by sashiko in [1].
Verification performance results are unchanged.

[1] https://github.com/eddyz87/bpf/tree/cnums-everywhere-rfc-v2

[...]
