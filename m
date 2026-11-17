Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904347;
	b=FDeLA24F4htn+vPWlcpXkdf8rMGH/rRV+ysdsrWCnFp2AvfiqCMyyzr8YHfu783AKNN6
	 CwrGJBFcRhlahN9SWYRXU31XhKueP8OsH3rdkSL2mryJejbj42M47bBZ7iSRpB+5N3tAV
	 ylje42kjxd8rBWZOXewQa2f5xXfZsdWUV1Qv0Pw+MdKE5Obbn8dZ5Ji+4opExELkzH+Gg
	 hU6yOSY4iAFVr5D+aUkNLFf0EH8h9HBjVi+yes+P7I9+ZufDMZYl4jx2u1s3f1SKblSzV
	 7ov/WV/dETY507y3y/E1a/+mVW9qsEjG6qt1dT/ur9ibPCRzb/jDyaI4YH6cnbSpGGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
	b=aAh1h83BQVx223jsMJ0nSyBJJwFOGXeqH2V7wR7CFT/vwHT0FLWdzXyxD0x8rKe41FJX
	 CpbKPlMchNR0T1q/2pmInzXVkZqscEN/6JolG1ayh40NRW9AYxHc71Y9lqEnNETH6mk3h
	 PDWRAOOXrECZzakTR+hT51iPtbvYutvnjK5/Qeyf+K7P8WYcBG9+cC2udZ8BsBGrzy7ag
	 1E0cY4XMjn2vFq0mVNrDlzwtuAaLy8mYRIJYmKs1T679uiJ6AmgBWjuJA/bZtbnumScs4
	 7ZIuLKyz2EmsS7tABPCQetvRJOQrj3cmToPiAvqCgMWgOJEOD+qpovepp/4c/fY75NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EFPX8Vuf;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD735606A8A8
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 08:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD735606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EFPX8Vuf
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a358881793so377435f8f.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 00:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904343; x=1795509143; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
        b=EFPX8Vuf7iz+NzEUQG+pPgjK/MbrESqv3n9ATmra3Zopp4tpstszPHFfE2sR6EI1XH
         /MuIqTxoWkMXSLrvcYnqUGQvNVGY6YndEf7Smwels/t/G0PiJAqa5YTB3/XSR2c5vF/4
         5S685rADCuM7kD+KTHsn5xD0Bbvj+kfNJN7h3Eeu6Tgpz77cxc6E5ixV5T0A3r/KAOuP
         +pclbSVYUTOzYQ2RRiRVVs4C5Z7y/NhXCRc6Of4Q0fL8jD/Em4FfidsaQN0h6TdkChBo
         DufH5bn8tmF4fp27j4WWCE7M7sjar8yCORXmuz1wFPQxfWworU2xHCWyEC/YN83R4E+t
         3i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904343; x=1795509143;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
        b=NuCdv9eXjW08yGIdqnfC9zvogz9/uT8lSW/Tx3neJ2R+zjM+vP1ZxAlALj47t5E6kW
         g2Wj/dy08w2YUoUWMvZoeN62IKKHVYYoLOvrGGMhpma2jsf4GcRGW/xTQ5US+By5+vJp
         dYRFg6y9CX+MEm5NJEGNXnL+87CIR1VuEKoXIu+Z1YPTsrPtv+AUYz1w4RCxUot4j0qA
         sOYXRjfkc/kRz/sTjqmigN8n3KSRk3FYSAXnvY4FjX3DWTpaxcalXMxlnAEf0zvbZzAE
         kO5MUUZcUAt7riPdBatP4oDD+QE8fJNAx+3YIYujf3wMAuhO1uZ084v9cTt0HWthwurC
         3BJw==
X-Forwarded-Encrypted: i=1; AL+hErG0dUMqdGmdz4mXccF37/QhjHcqOwQc9D8WV2RFgaHKwpTxtH/eNqVTZwEjbgjnIvXEPFM=@vger.kernel.org
X-Gm-Message-State: APuU4Z82c461XIXznY8ijzbTyrvU6yTYyvJR9SfGrSZUUac/90iP1Fkp
	lf5Es2wHtryaVYN4fVyumu8gKsHkg9xJXp8rsoCUBLVpiCwQs8sgA1dE3J6AlgsI2O9C
X-Gm-Gg: AZFdTZelejWg5NFaMmjKG2au2y0xvSVQcEDqoMjY1LIpG+wlJPnZkTGUPU/PLsVEePw
	MivzMkXjfGabNmcjwRp+7ubWN5UVrknC8VG0/Y/Ua0rRsxQ2SoKPbAePogHnsqIrQyDLbrgxn/l
	l6YOpWT252sdJc5VvD7M/g6bpdlU026nurp1hflW0ZTI+k7YL+g0sxQdZi74MHcMpkZPXu+Avdn
	uqh3L2twYKw+Lte79VgWMAHsKPeUGeW7BKY2W7EF1lBnAm+5plXYPZzP+7Y4/Ci8co8Ams7oMgO
	3WQ4PP0KK1HcO+Bfy0DIhlQKexB5TPfEkhRKPST2Og7D0MGz0UnPM54btiIAINzSGC8C4XmlZh0
	m6+b+pBsOKb/hEoprrtI9KuhT4WlVaquSfs/nFfGWGgq7dV+B1hqqw0iqC67cJt4MruT+SosF38
	k2ClnlImw1ExWdKkPUOHjLb/ke9TPRMuWop3MP6cOuQjNzBdxZlxHxyN7iPIxLvadI1r8xv+m8o
	Yz/DFOGiQy/NHsJ2WscBrbS9dec/dDD5xo1t1nEFcrDetb+Mfk8uL1AaXpxidA8L3gTpwkJvqyx
	mRhpJfKYvoV95XC40lTVcYjDPfZi7YdbV0Sho1LFPTvMyjUvgKL0+Woea+Ud/ufzFsH554z0LCa
	ELsC5ovuqTdZeKgNiL+oxyM9E4Z/XQKQJhc0zOv8t4r16xnvc91GObM0F
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr27089117f8f.45.1794904343236;
        Tue, 17 Nov 2026 00:32:23 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608d10b2sm43646659f8f.44.2026.11.17.00.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:32:22 -0800 (PST)
Message-ID: <fd39200976086130cc82d59699a988fc3e0689cf.camel@amutable.com>
Subject: Re: [PATCH RFC v3 27/44] openpromfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:32:20 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize openpromfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. openpromfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/openpromfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
> index fb8d84bdedfb2..6cd02d456bac9 100644
> --- a/fs/openpromfs/inode.c
> +++ b/fs/openpromfs/inode.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/string.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/seq_file.h>
> @@ -419,6 +420,7 @@ static const struct fs_context_operations
> openpromfs_context_ops =3D {
> =C2=A0
> =C2=A0static int openpromfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &openpromfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
