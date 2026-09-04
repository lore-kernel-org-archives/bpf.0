Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BFA439916
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558995; cv=none; b=gs2si4gqauOG8xAdm9cfk1QZVtJMOj/pacWG2iPJhBv/Xwxkx/yTfWIeqkTIm6XmH63ixanOMSuTMrprIUPiQwli/ecszXcdVy4/RpO05tPWgXZamcqOm/hFZ05TeN0d9lprcYlEXyWf+rqmsDDjEEkYpv+C/axOUcTynt/Slh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558995; c=relaxed/simple;
	bh=gYvcjWKs03ovnhF+rQqyMxd8n5Cu8GuL/DjQgG0WnWc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AnB/vIEy6uB2Xob3Mj1abGyZD2nVydXgxyMiMaHtOWuO7tifjgaXoJIARKPd+sPJCVdaZIRxv7NPqkcYNEsjeGhREVJvybCuqpL04OcnWlms0YVJX4KfJZoJJ/OoLmJwXcgHTAHBNrbCCu21WACCz5ORV/47UyUjiNCzF3WFyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcHTQfqH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcHTQfqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E4B1F00A3D;
	Fri,  4 Sep 2026 21:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788558991;
	bh=kyqRJ8clCii1j2ydMcFpo+mHFBNKPNNrqcMANd+/5kc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bcHTQfqH12SzLK4WEaU/M4upV7tldq3QvPV/0Zhkq5lt1Mv5d9o+4gWTTQigVx/XF
	 xX/IYlBB9DHXTujKdgf//vyoESW21vlqH335c9u1G8R5Tgn+NuA0VWSiUVH+AmnIMe
	 YQpxDPcHvfmPWKtAEJfyQO6TR4JmiuVGd1ZdG79rfaikQQlnKkbx357asqTfGdMyrH
	 t04yJwTgHkhaDag6ZDJ/jFzPjIK3wkLQUYGJ0d0rBvTmqu8iRxZjgB0izLIovaEGr1
	 KNulPdopDUqxdVSNzwhxm4B/JcQiUPFs/p6JKvdlvODKt3O3V2ioo4q6HN0HoTTfXi
	 hCMMRJUcRvpGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 01/12] gve: add struct gve_device_info to
 hold device properties
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903215606.31633-2-hramamurthy@google.com>
References: <20260903215606.31633-1-hramamurthy@google.com>
 <20260903215606.31633-2-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 21:56:31 +0000
Message-Id: <20260904215631.72E4B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver trusts the device-provided `descriptor->total_length` w=
ithout clamping it to the actual allocated DMA buffer size, leading to an o=
ut-of-bounds read vulnerability.
--

commit c3056c70d520a5fcb8777d7ecaee3b31bf27e333
Author: Harshitha Ramamurthy <hramamurthy@google.com>

gve: add struct gve_device_info to hold device properties

The commit refactors the initialization flow by adding struct gve_device_in=
fo
to store negotiated device properties. It fills it in
gve_adminq_describe_device() and its callees to prepare the driver for the
upcoming MailboxQ mode without changing functional behavior.

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index f05f4895f4c74..512349c5517f4 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -70,7 +70,7 @@ void gve_parse_device_option(struct gve_priv *priv,
> =20
>  		dev_info(&priv->pdev->dev,
>  			 "Gqi raw addressing device option enabled.\n");
> -		priv->queue_format =3D GVE_GQI_RDA_FORMAT;
> +		priv->device_info.queue_format =3D GVE_GQI_RDA_FORMAT;
>  		break;

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
out-of-bounds read vulnerability in the device option parsing logic.

When traversing the options in gve_process_device_options(), the code relie=
s on
gve_get_next_option() which does not clamp the untrusted total_length to the
allocated buffer size:

drivers/net/ethernet/google/gve/gve_adminq.c:gve_get_next_option() {
	void *option_end, *descriptor_end;

	option_end =3D (void *)(option + 1) + be16_to_cpu(option->option_length);
	descriptor_end =3D (void *)descriptor + be16_to_cpu(descriptor->total_leng=
th);

	return option_end > descriptor_end ? NULL : (struct gve_device_option *)op=
tion_end;
}

If a malicious device provides an AdminQ response where
descriptor->total_length exceeds GVE_ADMINQ_BUFFER_SIZE (4096),
descriptor_end will point far beyond the actual allocated DMA buffer.

This could allow gve_get_next_option() to return an out-of-bounds pointer,
which is then dereferenced in the option parsing loop in
gve_process_device_options():

drivers/net/ethernet/google/gve/gve_adminq.c:gve_process_device_options() {
	...
	for (i =3D 0; i < num_options; i++) {
		struct gve_device_option *next_opt;

		next_opt =3D gve_get_next_option(descriptor, dev_opt);
	...
}

Could descriptor->total_length be validated against GVE_ADMINQ_BUFFER_SIZE
before using it to calculate descriptor_end?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903215606.3163=
3-1-hramamurthy@google.com?part=3D1
