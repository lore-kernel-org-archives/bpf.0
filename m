Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903941;
	b=IDkWv6PeF46eqq9QtAK9Us6DnNLaeOnUr03bd4FGipThCw3s9jEj+CrtE6p90sFKHe5A
	 7nmAwYs//iXDId2YJS9hEoLcpi1rAJpUiZ6Zbr7O0+DirkiAG0gY9W5bGK8fAm+LyW7lP
	 eF2N5RKvjrSJhaN9igo95mlHcltxezCzqOI7PmmlkJ/2Lgu4ZSitifuJSF0Fos6XOj+Wn
	 OJOGO03Hf3Fhs/OsDLlR88pAJR8PX/dpd/BwLh7VZd3smET2a5iJITw5QLmsqJdHe3Cv1
	 fcDwfK57qzJ8F7h3brHdYZVIFxRBLa/cT0ipxWcj8usg2s2QldX5HvYuBSrFDWN9XYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
	b=XMgtf1aYjZ6+ZZkfSe4QWmLqCmVlYETy8BUhG6UxD87j5nsYIgQpQxG9ux6tiZ/wIKJy
	 EL8jIkg3gRiMsEs1Sgk2uV5n+IgLA33uP08iTK9rzBFMJJHMG8T6BnsVC/w6S9My2SoCK
	 48Dx5UHK+kQDVkyxAD0GGYOM/FkVD2utVSqGTUqpuW28pE4MlWCH2o5OR/g+Capr43wMu
	 VESa3LlWhgapFDlek8Hcbdfk6kP0r2nraEqXNoshrwsd3nJtHAvU1MF6wapbARwNCecEv
	 hEzeC2Hyv2TvEQdGS/XkwaNzbrM9GhGiseVG/MvpihckyiDfn4NsvHnZGy8h183fkvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="QoCmkI1/";
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD950606A32A
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 08:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD950606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QoCmkI1/
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48b001cd92bso2841199f8f.2
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 00:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794903939; x=1795508739; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
        b=QoCmkI1/XbLLMuB5pWQjj6w7lhYbbqiM96jQW+pj9RZ000aRRl9S7H2qSmbtORMNOo
         ePt1TXAWzVIR/TrMeI58Zu3n81XgIdPHavzyhyljr/3uEJYZwsW6Sg14gd450d308jE0
         RrvE2vSlthe4MhW9V05IsJzW8g0CM3u+nfQ1hkfntpYQW6a4z4zmXmxD0w/TiuzDbd7U
         U8xZ2FexNWbZhSQ3d3pA0tlH/f0MOfn4O69UeuIyRM8vQ/YXTKpGPDyGoQczoxEfoynP
         BDcwZppUf46pJGXZ+RH52kug0iZSl25eld2NGIqCa+XVs4XFwFr0CZI1pzljVyhbNHw0
         NmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903939; x=1795508739;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
        b=MdiKhSnlgNxtNHBJQpGS6RBEjt+/4H5j0NAJCEW34avCTV6BfhsLVGWsOaiEw5vG5/
         lW86RBi2g1xz3nu3CVLN4rkcKtWHjV2EP+vC3SAr/TQckqA4h4AxkjXps3KgS+7A/JpV
         9ZdAX3dSZ3v8OHqy5MjOyFnUSw8C9w2SSFOACUpc0UE4p4wGrXTGme8Q4u9kwQlQVL5p
         P9SZCVox3RmJr4YtIIXrwXqLH97vW1Qm9BfTyLoqB485UDG40Yi+hxvr3PABmBMWrcBC
         fKBDXtDczmjYqAGTydCxx5Bpjx7xVKKHrBYcTrskInyjkTR+2a+sNBmBRcUdUlwNFu5p
         Z0Zg==
X-Forwarded-Encrypted: i=1; AL+hErFjoHY/zbE9fNS6Y3UthXNOblq/MRwNtN0oOSllgGHSBWYEc8E/YDeFeOF5det+4mN3/D8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bGnUXBcFYn9rV1gga/70osI12KN+YLqaqos0BK7rSDERyxCeL
	1hK0JV5wi/saZMjuiVxOwDMmhsLsAoJH/ym1BPOVkpiCrsjx1fdu66pRzSDgVB9QOsHE
X-Gm-Gg: AZFdTZfrBSPdAALtnJ3p0aQo0cK6YaHvAspSbBIv8775d0oUv4AOi6Hej7JqCk4012I
	0G/1c9pCqVJTx0t3eu9wptMa+e3iCZnhYZt9EcE6gjW8ugLX3tYmcscbcewqmNDe6dQRLUlFLvV
	ccxsbZDkMdmLXSdbzfF45gLJ8MNtrG7UZ/7zU40x8PBUMMzK6nDKc9FaPfK1rDYucJKLBSd7ImW
	MlQeGubPr+VycCUv9tS/ZJ9GjSR/VP0n8pf4vEbHpGAzexBKOagSipTB83iX0Ob6PbzEcoQpt01
	0VnK7W7qsb6UW6Hs96WiC+ih5mEGwYlyELM5A+jtpKQO0dPzZpIAPZECijuWb0/9MCQWXA++pwa
	SMRUoGEnQ79PG+/ZPrS3/vP8soDJFUKNbdB0LnhUOf7wpGRCRrFOOclGBABH9jjselVM8xtZx47
	VGelpGR5rCRp6VXdA2+gf99h7dwrzZM4JZqmffqCkMYErG6MjAHNop9/i7ywA0G3QPI1AlyMJsZ
	gIdwnMZs7fl1k3fnXWq5r6J/nDHat9z/57m1SOPYitV7S0Dmv8iYqE7OMyhgPG00iQnI9ssdJD7
	imn4HMuJ9rfw23y1wstr3phX2gM1DBV1I4ooXzallo/2I1ILGKu6lWydppKb/FZmz1lj6l96EjT
	X89Nh205QCjYuIQArSa4TRhY+1hi5d49qZCJuXU7RCM/q9DGCr12X9XM6Hiy9ta9/AB7h/xrQWn
	xGHQ==
X-Received: by 2002:a05:6000:2084:b0:492:46e:d4ce with SMTP id ffacd0b85a97d-49c6fd932c8mr25238543f8f.13.1794903938925;
        Tue, 17 Nov 2026 00:25:38 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm26907832f8f.28.2026.11.17.00.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:25:38 -0800 (PST)
Message-ID: <a9124bf1c858cef3e8ac06b1b2396dcb0e19e2a5.camel@amutable.com>
Subject: Re: [PATCH RFC v3 02/44] nvmet: check that the file backend
 supports ->{read,write}_iter
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
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:25:36 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:04 +0100, Christian Brauner wrote:
> The file backend calls ->read_iter() and ->write_iter() of the
> backing
> file directly but never checks that they exist. Everything that isn't
> a
> block device ends up in the file backend. So a namespace pointing to
> a
> file without them calls a NULL pointer on its first I/O. Only
> buffered_io=3D1 gets that far as the O_DIRECT open fails for such
> files.
>=20
> Refuse them when the namespace is enabled the same way zloop does
> since
> commit 0c10f8a1a7ae ("zloop: check that the zone backing file support
> ->{read,write}_iter").
>=20
> Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/nvme/target/io-cmd-file.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/nvme/target/io-cmd-file.c
> b/drivers/nvme/target/io-cmd-file.c
> index 695963dd932ee..dfa8aa46188c8 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -47,6 +47,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> +	if (!ns->file->f_op->read_iter || !ns->file->f_op-
> >write_iter) {
> +		ret =3D -EINVAL;
> +		goto err;
> +	}
> +
> =C2=A0	nvmet_file_ns_revalidate(ns);
> =C2=A0
> =C2=A0	/*
