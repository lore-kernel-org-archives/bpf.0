Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564338;
	b=g8p5l85ABjPFaVL9HFYF4jSAdjBRLQgnIr3oQfD41oVoUFpUMDt6KElr4gggAAVUYLUa
	 aKw/M95eLFJ3bROAyer6uMSz58ja7vslkwxIbqlWH9o2NZ8vZduiioAlh4A7o4W3GNf3h
	 pRB+TbHSanf5GgCgeRTUnwOON/IwUBldVAavnrgjjQPuqqm9m+vjIzY+rGPBuEqfyeIpL
	 FA2ihLMjx4TLEhJym2BUOCy/xs1a/SZs6Q87seSTvQ5la7d2+zopN5UE9mYQNfnrMNPiC
	 jzsuneDiS29ssRgB8ui+EpyngiCkwy+M/6eX2zyCFTulKLiMDlMUXOPx8vqaan34ZbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=/ZNAGjGCHSUHK/hbpNrctHFuArQcFUaSPHFuYTd8W2k=;
	b=W8u5KFMHJbPzQNMz3zJ9oouF0nUNiCQI5Jjj4IkNt6zJbyy2NyzkoQHYlMIMVASfGiSV
	 s91CziUPRKK2d0JqcXLOpAVAxQclQpbqfpsEImpgB4XkcZM3xjNxJg8eyr/R3b1Ba1Rd+
	 CpBm8XCcd9iFwA2/DG82T/VQp5KEFkudthWyz2SQIcM4yq+jBAfQLObA0DOwxAgP+YmZ7
	 9+PYbpePhMNvaEhsTqKW9nNbCDbvtUBJSZ+hb02nCocca88qeML+r2nhbOL+Z+TqRC91J
	 gsTHwpErb8muyU0gO5SqRFAWF91rJcbi7M53jAErd6z2plkcbDEwFZ8EvjRwH4c/OYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="BcN8/JZ3";
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BB8606B133
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1BB8606B133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BcN8/JZ3
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c50a2efbe1dso79590866b.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564336; x=1795169136; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/ZNAGjGCHSUHK/hbpNrctHFuArQcFUaSPHFuYTd8W2k=;
        b=BcN8/JZ3o8G8RngOszXG3JTNOcmRF7Y5HhcgHfEFuj8bd59D6/ZB+k5Qh/rpeFRCcR
         ddACGgLLZgU5b3f6uROOjMlLzNHxLpnDWTvmFTIG7dNNkaJHDW07G6TO1gom3Rvc3G6a
         phj31A4a6/nEoCYWD8i1KXLteYhy5qLcfDwMY03tf9yOOPsaa+sC0St/LDVgowIEHsk0
         tZO/CMI2RrlSiK2F32OSWBbCdipxonxIIN0DBtho56nDsRF+fFDKa92VHmnJVt2oHACg
         qH7hz+1dQBsoiVIgFoQGohYiLAIIKP/PCGAm0hHsixZQutOWB167lk9DbkeNw+vQ2Hrh
         L2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564336; x=1795169136;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZNAGjGCHSUHK/hbpNrctHFuArQcFUaSPHFuYTd8W2k=;
        b=uq9JpCQWkMDef8xxAch5B8IBGYAZW64U9iAyY4hIJVNyQ6dNDu/7RxxqmrAu28NHx6
         rp1KBXt6YwU40jBxV7PFXYoBizT/74GQ6RSCTMnqbnP+2TuWtOyOiVRr++AnG1qwK6i3
         sh5kpeOLa/AoJqJgL3Mwou1lt4WrfxYffJE+4lhHhttcWKWUK2vOubq24DRImqttVp0B
         iKG8oBR3V4gnUp915oKhiFO3RVYl4UvtLl8rvBY+aeJeq6Xc3cZQ7ogI1Qe5/hWzrIRu
         m+MdCt/1cjfReVdQGAp+M1CK0wJpPAJYzQfn2TOl3Q9/1FM755uFkpjZxEagu53ZP2ws
         gn0Q==
X-Forwarded-Encrypted: i=1; AL+hErGvx+fEKWeLw17kDl+bHWdt2RlMJseXPcrDGlhiJZ5cbZhACUgmg+BdBrwyv01QmBnc1i0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7xDmPViWqViCbSSoCQZOjshCMpO6g6O2KJKT4M8Gw+GdBgskU
	2E/XJtgNZdDJH8cEo1KgzSrf+gVR4WndNSdbPbQLM22u0LInDcXoOIOAPHRjunqYq9Wl
X-Gm-Gg: AYBFou03Ts+vKaA39toGCk33Jqq+uxSDgLrM7EfEp57iFN8NEufzSIAB7jyFg+iZ66B
	V0ul6HspFYUrisgFrkgZXooLBNVIwmcn4EvE5yH40Bnn9a0e0D+ckyZDTVPt54tsw5xo4jDk5ws
	lI2JaZuNJ+9X4hViYhk5jWzPLfVvzkE8ge6sX2yuKn+sNQ12mlin8acAwFo86Zl0mO256kUe/sB
	yaSrgrLTyR1YSknTXqbOUtTSPYfuWbyaZA/xXo8WZtPFUzMHsqpGuD0pKnECxE6mVh+8DoJjvsX
	d5sDH1foD5oTrPN6Sg53DCYf5+MpferdMTpLGLYBMJ5OF1reCDHz6BdpAMWOMhYiR4rX7TOwxF9
	zHWTe9bPwflAsBDLIggCa3E3j76IeE6yRG8rEhaL/eGIvMQarb8JNhLSxRaMQdLrJhXTbT0QdL/
	3ss1lk8eA1PeQ9+UwF7nhzO5eG/zFcI3ETlgjgg6Ht7dFZ16uCH5GYl4zfUgBPiUMbOSyrp9vM3
	X0B2G/eSevpWNYqbgUfjM11rgJLg6cqkm6uvhXNETyCJibxd9856bpySTf6IuRmylEuOt9UGECv
	5naXSg4LKnGvmBs/d4LLP9An2uNuj009fNkPX0iQLqUXYSNkRaAeJHGFy4g8m/M=
X-Received: by 2002:a17:907:94cb:b0:c2e:3a72:ffbd with SMTP id a640c23a62f3a-c5096389759mr162937766b.41.1794564336347;
        Fri, 13 Nov 2026 02:05:36 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095a5b93csm75365566b.5.2026.11.13.02.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:05:35 -0800 (PST)
Message-ID: <8f532a01f6cc2eb73582864343e25be4ec990919.camel@amutable.com>
Subject: Re: [PATCH RFC 14/41] debugfs: use fc_init_pseudo()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:05:34 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-14-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-14-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize debugfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. debugfs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The debugfs files that
> can be mapped, kcov, relay channels and powernv's memtrace, map data.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/debugfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index b4915551ad31..f163f0bc5703 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> @@ -317,6 +318,7 @@ static int debugfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fsi->mode =3D DEBUGFS_DEFAULT_MODE;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &debugfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
