Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610652;
	b=jc8KkXnDXFq04cSJfavhVq3jmfeLUuIKkKynkJ83FlX96CDswprTwsR0Iq/8dACm8YvY
	 OzmB8HIp5hutk6ZUwxx+XxqCt5WFvGVSmDVnMj+CrKFIp5cIP1xvjziCTVI8sefXhsDNd
	 CrF/Qglvrn1pHeoVfHQIuA0McjFcBT70nBQpbuNOeogxN6j4gUqgVHqensykatshyLAdu
	 WHDZBYbmKVha5u0JiU121sdzfYDGhB1nSUnRg9zEQBB2qOWG8F0tLGMAW7/uR1pIV7ujt
	 1vNgvMF7LU6srLSMEKhw1ZKxJzzvpin8T0ITRcWF6XIrN8UfIiLoPb/hiyPp1choutA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=n3kRI1t8FC4sBJ1KlH6nbApPr67WWAzYu4YOF8wU9ro=;
	b=2tPJ8Y0kcinGmFFzu9bQ/UVOalknHRu/6pFbAmU3texvnVdnFOiaBjs8r4Xf1eObVplc
	 0fSPwm4QxapsJAySEGrdiOJwJ68PSN/jBG0dibK+wtYPLNcV5V+o2ZwmdOeUPJEcckeNM
	 UUVCzIzkrVZ/8NgmijYEjeSqYsD3pYa2RZDfR7OwRT2Z0z+LkfAhyqINBawo+6mdN+E8B
	 6aBzzp6fRlHmvD5CdRadV8dDJ6jao3vsrOyk0fQ/03nNvzN4y1tKF6JDJWJiSK28oBNkc
	 S5txKcpZ1wrBzs6xMYY8z4+mW4Y7Y4mRpSMtlOu3rYdezdQQJprpbMKU7AaNoA0fFnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JcoUc7GM;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A24606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 12:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73A24606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JcoUc7GM
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-492f0a1b685so3966476f8f.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795610650; x=1796215450; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n3kRI1t8FC4sBJ1KlH6nbApPr67WWAzYu4YOF8wU9ro=;
        b=JcoUc7GMiAh0LkpV1E480w7GXCIAW/e8cF7hpO69S4aq0dcYx4tjFtoWiYr/DAm4+r
         yQ/2E0q/ZEtANpcmhRiWttvENm2b4bj22INjO2Cx/R+/hBXaXVuDkjlb15+GWRRpJToA
         gOt2R0IR6kS/Ao9M36XuCAmR5ct6HS3dYddtARbxeWS1JjHEBmwNCLXhc2QkvjRgk2lT
         AJJAOIWWGoD+UkNdRCPXyT74UpyGH73ouJzCAPdkF/Lr70PZiakzkApmnO3aBQ+SwCeG
         0TuQ+Y4k0z+qEetWXaTlu1C1y6AjZth3CoXXov75D3SM0G7QrDYTrkbxN01Y+ILgo/HG
         90Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610650; x=1796215450;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n3kRI1t8FC4sBJ1KlH6nbApPr67WWAzYu4YOF8wU9ro=;
        b=ZBMdgW6gVpAY26HbHu4hSYSakvnC3ccgkOP3EXqVhlj74GHQrH9M1lxsj+F+H4gnXO
         rVUj2osVDJlz7IFkL3b6QWgTBSnT7qGfl1einny2FjY7o8lvK1+xZmai3NfR0HnzH9dZ
         Foqo5tivVppPcKhk1XECe2+87ZWS/C/hNyhy20FWdd23GrmKdpnIn9KaBRHsDx8fP+gQ
         w4FiHGZNTJ1+Fy3rxzmKRa5F1pIRbof4QU32TCJcSaQ/7j55Xxcqy5R2D9eE8GkDx6/W
         LJlnNmw4xNsFViDsKzj+an7Am+QqDhU0bT2JQjDj7SZ3Tbqk2HDNQ/wdJrLTlJJfcX7o
         073g==
X-Forwarded-Encrypted: i=1; AL+hErEIFGjbRnbxf/2XjuyD6GfEDtF+BO674xVWuNTwaAqqP7MJpu8+faLOPBYO4hsih5j1mbI=@vger.kernel.org
X-Gm-Message-State: APuU4Z83vzccjaXXkkdgf+nYVqBWJ+8DeCnHEPtXIplQ82DvSO2YnW28
	s8bJjOJ5m52W/lpnlf6M0w4QM18eZQzU4JeR0tHi7G2OQU1mlE8cn+qB0WesGGyMNgi4
X-Gm-Gg: AZFdTZcmT/2d3TWi6eTNMmgMbQy2+/im77jH8dtaQeCCDhA8BSLlPBXwfwSv+nt6RrK
	xLqDILCJ4WjSFItsjBjng488XW+I5yBn/w0qNi2gXrW0snAQme20WrfFnsRSVxSdumeUC6238Ey
	ZThGVdJIEXl5L5j2zNZq4HG38XwCeqfIIEWEiCFga3kKRMzXVC1+n4YAUcnMCqKtrhM81rBmOT0
	Oaq4DVeisL+T/9oZwxrUfVsHWln59g+ovrSpiSPBpjrV9b4QppAvK+hbNRomcT+2iYYWyUGLH8k
	XohmkEuomZTiLSm1ZhgUjI+TsSrJ27e44DTlDZ6u54JeirMVSn4i21joOZDD6McWMVlsbuvtLfS
	2+2t1cBcV/BI8aPpIa0k5c80alJJJPx5oJxQwDQNCDQH9tbfbAXyXz69zBm6rE61J7jkRbcHZho
	sFUve4beXPa2rtB3qotTdaGUbGMBW+ImYCUtYg1To6EeZaOcRDw1poktYU+F5dBggQEUzk2h3QW
	UHlDB6V+ZJBhZNCnK7rw9AL+uEg25o5l+9VjzHYLrwxexJQ9LoXG47vbbRnS8DtquLMZPt9Q1lS
	NsBV9AT47jCF6dS2SQ+RaHTL67hbSzshhY1E/8sYaIQ39XUVoL5jlI+R1JUwue6/V3N5Y26zt6d
	ydZnQS1xJw9wHNn9kkIx/fdJgTL0HMBE6/GZjsGDRmB7feCtJxERJoVs=
X-Received: by 2002:a5d:584f:0:b0:4b9:8ac3:f5fa with SMTP id ffacd0b85a97d-4b98ac3f6d5mr4714062f8f.48.1795610649431;
        Wed, 25 Nov 2026 04:44:09 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:c235:97b:8b16:8928? (p200300cf572c2800c235097b8b168928.dip0.t-ipconnect.de. [2003:cf:572c:2800:c235:97b:8b16:8928])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm38964871f8f.24.2026.11.25.04.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:44:08 -0800 (PST)
Message-ID: <e6c23984f7b47f9dcfffd6de2f6fdf75d07a14fe.camel@amutable.com>
Subject: Re: [PATCH v2 01/13] ovl: don't warn when the lazy lowerdata lookup
 fails in ovl_d_real()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Miklos Szeredi <mszeredi@redhat.com>,
 	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, 	stable@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>
Date: Wed, 25 Nov 2026 13:44:07 +0100
In-Reply-To: <20261116-work-ovl-d_real-v2-1-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
	 <20261116-work-ovl-d_real-v2-1-90564c4ae347@kernel.org>
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

On Mon, 2026-11-16 at 10:43 +0100, Christian Brauner wrote:
> ovl_d_real() looks up the data of a metacopy file in a data-only
> layer
> itself if nothing has done that yet. If that lookup fails it WARN()s
> and
> returns the overlayfs dentry.
>=20
> Commit 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in
> data-only layers") assumed that the file would be read before
> trace_uprobe places a uprobe on it so the data would be there
> already.
>=20
> But nothing actually guarantees that. trace_uprobe takes the path
> from
> kern_path() and calls d_real_inode() on it when the event is created
> and
> again when it is enabled. So a uprobe on a metacopy file whose
> redirect
> points at nothing warns twice:
>=20
> =C2=A0 ovl_d_real(/f, 0): real dentry not found
> =C2=A0 WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210, CPU#2:
> sh/279
> =C2=A0 Call Trace:
> =C2=A0=C2=A0 <TASK>
> =C2=A0=C2=A0 __trace_uprobe_create+0x1869/0x25b0
> =C2=A0=C2=A0 trace_probe_create+0xcc/0xe0
> =C2=A0=C2=A0 dyn_event_create+0x46/0x70
> =C2=A0=C2=A0 create_or_delete_trace_uprobe+0x3c/0x70
> =C2=A0=C2=A0 trace_parse_run_command+0x1a6/0x320
> =C2=A0=C2=A0 vfs_write+0x1cd/0xfa0
> =C2=A0=C2=A0 ksys_write+0x116/0x250
> =C2=A0=C2=A0 do_syscall_64+0x10e/0x5e0
> =C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
> =C2=A0=C2=A0 </TASK>
>=20
> bpf's uprobe_multi does the same.
>=20
> A failed lookup isn't a bug though. The data can be missing, its
> verity
> digest can be wrong or a signal can interrupt the wait for the inode
> lock. ovl_open() simply fails in that case and
> ovl_maybe_lookup_lowerdata() already warns ratelimited about failed
> lookups. So return the overlayfs dentry without warning. That's what
> the
> WARN() path returned anyway.
>=20
> Fixes: 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in
> data-only layers")
> Cc: stable@vger.kernel.org=C2=A0# v6.5+
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-214581@kernel.org
> Reported-by: Chris Down <chris@chrisdown.name>
> Closes:
> https://lore.kernel.org/all/20261114120557.4bc1eb6e57218cdc@chrisdown.nam=
e
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/overlayfs/super.c | 10 ++++------
> =C2=A01 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 08695a99f4f93..1985b553a47b7 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -58,15 +58,13 @@ static struct dentry *ovl_d_real(struct dentry
> *dentry, enum d_real_type type)
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Best effort lazy lookup of lowerdata for D_REAL_DATA case
> to return
> -	 * the real lowerdata dentry.=C2=A0 The only current caller of
> d_real() with
> -	 * D_REAL_DATA is d_real_inode() from trace_uprobe and this
> caller is
> -	 * likely going to be followed reading from the file, before
> placing
> -	 * uprobes on offset within the file, so lowerdata should be
> available
> -	 * when setting the uprobe.
> +	 * the real lowerdata dentry. Callers may ask for files that
> were never
> +	 * opened, e.g. for uprobes or O_PATH files, so the lookup
> can fail
> +	 * here. Return the overlayfs dentry then.
> =C2=A0	 */
> =C2=A0	err =3D ovl_verify_lowerdata(dentry);
> =C2=A0	if (err)
> -		goto bug;
> +		return dentry;
> =C2=A0	lower =3D ovl_dentry_lowerdata(dentry);
> =C2=A0	if (!lower)
> =C2=A0		goto bug;
