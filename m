Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72E03DEAE0
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794301; cv=none; b=Gf0YmKqqtliMpwUtNWQm5FXUzSboFPFZZTnT/uibk2pnLGw7YPrl61hoOkO70TWgS30vSGzIDFTbLUD7Z7z3L2EfdBm1azUpVQ1SQ9I3LVEr55xhkwKylh7VIMhFbxQpdQkC14kOCAawp3/470VjFYWPRRjoUYcN7UD4UNSjcAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794301; c=relaxed/simple;
	bh=ogAKG21DIEnh1BXhDZHVG/IL9Wf5+K7NszvE4vdVVO8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AKMwFEZ02NoZEnMyME0hv07BDqwTQN5gTtjHkebw2mrKl1+vj73LUEW1l0MGyUP+eOS5I1aY9MlBEPOz6Dw/mQvFraNEJJdrDAYs1g8uE+eI/Oukqban44uDsNcaSCuclIU57JI+cf3RPc7s1lyRm3UiXV23v5iDTBZv0xojaFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L14khyIV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L14khyIV"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-83537a80ab6so7262620b3a.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 04:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779794300; x=1780399100; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v4kEI0Lvai4x+AIevivvothyJtprw5m7bGCMm3c8DSA=;
        b=L14khyIVxIfTVXb/qLyzPmQJCvdPCt2QmJny+7aBKn9gAyCjRV2+ksDoElH8/75bhm
         Z9fAmWJYOYr5pQ0hvNI6xQDZQ+2o4gRDkSQPEtoni3NP2hOwrAkC5O9r4SdXJBO4C+Ek
         SCwV9VTxijhdrO7BK/xfohZgSzSI8vFpk2MeIWMuH8nfG0e9LKYIoaI0WNXNT5miQg2p
         XR5XVLYR8BNzyipZAJGVKosbCzmqH1Pie1hty3hI24foqg0mgooJwzO/wcsvkTRt7k07
         FMC+T9ZQEuj4MSPkKbKYi6RmsUQJYlnNDF8psQL9M6VLpR5gOwxh7o5ceSlqxOMSGxpc
         +DPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779794300; x=1780399100;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4kEI0Lvai4x+AIevivvothyJtprw5m7bGCMm3c8DSA=;
        b=eCmi0EvYEW/XRDKoJb2V1H9pg136HpaaneWmDsmTo5zJgnUsG080TF/T4WQyo6/uX0
         HkAWQkNptpW3NgQuh8JIKpQy6r5sUqygIGpwodPmCUnGqwWZOvH6/IzAxxsEesBPX9ML
         g40A8yBROQQLErdjdhDzFBnkfrFv4dpj+gicsD6QD09f/e65VcEXlAL/FvuE94V25vwe
         t9oSLVOxvP9aPLafAlALokStKCG46aMKlIkGKwcUBdS/0/CEp/KSwpuovpgDdplVbH+v
         3QIqhFRFajM0+W8lKLrek+VUOlSIWgTvjNOd3YtIYGesh2Kwf9O4lSnld31iV/7ki8Nq
         +EVw==
X-Forwarded-Encrypted: i=1; AFNElJ+fHmxm/qLGJqcgl7adFW+ajsaCiAT9pI0/KroImCLAoDV2kODy8ao+J4G2ff4TKL2rL7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF7nO8+q3qlT2ELWI+w2Ilaf5EeFW+CvMwONHN87OESQtSsenQ
	IaEDJyT4q3QE05r26c1nLM3YN5HK3JZQOsWd9STGITtSlEiOqIXNId1w
X-Gm-Gg: Acq92OGokLiHAWBSpI5BALz42DssZpwedkWpFJiEwMzN7ghlX0WG5lxkAH9HG5r5hBv
	ffXHSoRH2Dm8m3FwGB5d2HiYnDtCsizjpG9v3rN8KPPotkYYcrubJ7LLTkgKtv5BspyEWTicJBJ
	96kTTDjNy+JRbjXPDqA38qn2KBAEPXp7zODFA4jfgToHWPYOP71AHu4GyBelpfbSTok9Bz9kW2i
	xh7irKnsy8groTwDtEs5sUI1uFBjz8qMvH1ys488KwQ6Q2yOKdbDSx4qu/TG/nyzRy0m4/8B6R0
	dM44D5naMV9/y2FPXBsF4M68RkDGwjX/jerZrYUd/ocq+gVybsSTnPdM++AFql5nfYqWmnZxmY6
	53+IT3UBvC8dBdsxGK5oH26sL7aOnFRGzpnyqYINqFzu5mHFC+zIH8ggUAqJSKbL/+cn+awsWg/
	4IFZMHBI9YcFBZxaFANzXn3h3seOkWuf/Sbx4H2h++RgCpy/1ETIHVDH+waW+l6w==
X-Received: by 2002:a05:6a00:4c98:b0:83e:2c38:f5d5 with SMTP id d2e1a72fcca58-8415f32e0edmr17278544b3a.28.1779794299868;
        Tue, 26 May 2026 04:18:19 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fd80cdsm14493051b3a.49.2026.05.26.04.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:18:19 -0700 (PDT)
Message-ID: <ed4fba3c27ebbfdfd8dca50d52c05e0f4c9001fc.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/6] bpf: compute loops hierarchy
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, martin.lau@kernel.org,
 clm@meta.com, 	ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 04:18:16 -0700
In-Reply-To: <17990ac45a42c5a9b8147bd9fbac3760467fe44b4e5ef8068da3c9a4aaa3ee5f@mail.kernel.org>
References: <20260526-better-1m-reporting-v1-2-51e4f2c59780@gmail.com>
	 <17990ac45a42c5a9b8147bd9fbac3760467fe44b4e5ef8068da3c9a4aaa3ee5f@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-26 at 10:05 +0000, bot+bpf-ci@kernel.org wrote:

[...]

> > +int bpf_compute_loops(struct bpf_verifier_env *env)
> > +{
> > +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> > +	int i, err =3D 0, len =3D env->prog->len;
> > +	struct loops_dfs dfs =3D {};
> > +
> > +	dfs.dfs_pos =3D kvcalloc(len, sizeof(int), GFP_KERNEL_ACCOUNT);
> > +	dfs.state =3D kvcalloc(len, sizeof(struct dfs_state), GFP_KERNEL_ACCO=
UNT);
> > +	dfs.stack =3D kvcalloc(len, sizeof(int), GFP_KERNEL_ACCOUNT);
> > +	if (!dfs.dfs_pos || !dfs.state || !dfs.stack) {
> > +		err =3D -ENOMEM;
> > +		goto out;
> > +	}
> > +	for (i =3D 0; i < len; i++)
> > +		aux[i].loop_header =3D -1;
> > +	for (i =3D 0; i < env->subprog_cnt; i++) {
> > +		err =3D compute_loops_in_subprog(env, &dfs, i);
> > +		if (err)
> > +			goto out;
> > +	}
> > +
> > +out:
> > +	kfree(dfs.dfs_pos);
> > +	kfree(dfs.stack);
> > +	kfree(dfs.state);
> > +	return err;
> > +}
>=20
> Should this use kvfree() instead of kfree()? The three buffers are
> allocated with kvcalloc(), which can return either kmalloc or vmalloc
> memory depending on size. With env->prog->len up to 1,000,000
> instructions, these allocations can easily exceed kmalloc's maximum
> size and fall back to vmalloc.

It should use kvfree(), yes.
