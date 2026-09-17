Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834013EA955
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668153; cv=none; b=MfaAO+sjg4HLBasTZ/yTDHxS28hNkkEpZR9MfKjj8fL9f388LFHcDPfr71NDPghvtCWP55BPcAzc3V4NQkoLuvoEbNw2niNoQBD3fFt5lczDxGYVpqls20xS+2uNxXRnQ6VkXAaCpA5G2yPKEvzUHZuofYV17dHvbA1cextEXDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668153; c=relaxed/simple;
	bh=cxS7Rf5IiMOsBdgURLuM5pIlrTw3/34bzMbKDyP61fw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qJrAKRl7JWgPHWym/REUmRYkdN/EEtediPJG/n1+HqgAAA5NKD1lLWVEdg6pdqmTrodAUTPN6pgmZ222VoiNT5qS4987qPBdKfLlms6AlJIFLCZd2wKw48+nNJh9TyStfwtBkzi2iXEx4cczR0dbYKp0ZCdiB68MJNcKWzAmq6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTfrKcog; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTfrKcog"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cebcb8d7so320837a12.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789668151; x=1790272951; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cxS7Rf5IiMOsBdgURLuM5pIlrTw3/34bzMbKDyP61fw=;
        b=mTfrKcogLP/NHgwosqLqvbPTpEYZlVOGPVqzaqwuaM9PyXJ5an0NsTMbIfEyuiamy2
         mEMwPgwAGoNEFLJSQpAhMFMuL0DBbYzAacLdxZNyp2iONObf9IAF0MzxtPuc7r+07Fy2
         RF3X46QP2AEhOrvk0hJqAArqR+CxE0aT15Zhe0+iRs09JijhP4ToNDfSEkpx0AA7zKiq
         NckyCARAKEjqRpL8QoGOu9KUTEPZfVsXt+fFC6OM7PJD2CvGndpBn+kIlX3LAG5clxKa
         nhPq0F6b5GsXiTLLS5FDflpxifCtrp0PbXvPXRuXH4nMOY1V5GHws2AMSuz9qyYzRtp1
         xpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789668151; x=1790272951;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cxS7Rf5IiMOsBdgURLuM5pIlrTw3/34bzMbKDyP61fw=;
        b=GKiUfOhs4x7DGhhPSFBRPb5tART1JklCThlMONHgZc3Adn8WVuGiEaFxv3pBPHw2W4
         JQqdvdtlX9/PD3kV8n46S6z8EjCrrdjx4yd5t9HL1NJqHGPJcGv0fCjJ5wnxD9le3PQ/
         7gmI6LBjSTk8JEaF1ESAx+tTh68Lsr7eBvLlI74CmRgawniCDPowhTaY80z1s+rL9Si9
         QqFmDQ536OXt+88iUA1a+s7BxLyeC1Gc+++or/TEHEfRy6PrbMCB7eptotOIrVp3ekJy
         40y4lSZDfiTb8orlnUDW+2OOsO59zioGj6mSpOLFpyR+zo8zt/nx4mO5slms5X9ZrwG0
         D3+A==
X-Forwarded-Encrypted: i=1; AKwUvBzrjtJWR5QkO42vgSVyN3R30JoYqsJGOyZMB8sQ0iD4KT+tW/VbR/G/5YAzijuQ8KCxblI=@vger.kernel.org
X-Gm-Message-State: AFuF++kccjMahD75AwBYuxEdPjv/Y8DUkjD8HRl3DGWORehwlPrP5zTK
	ukXmgVeudbv5jFbe9FIfi0YPh+Gyv95VGLUO3SLPCcMUr8DnOb9pHfX2
X-Gm-Gg: AYBFou3mtsSIPZxQmTA51arofI/KbPcyho4QCFNjZGVLqtO3Ia9CD3tzbQ+4p5vT56E
	TcynRw8qg4KjsVVgf5R4bv7W0CYYFZ/d1AzTjIvgSHmbEQIfX0qSHlLQGZZTVw8yh/Tpw5qrf1R
	RA+AiQcld9mQf7rweKGsAnLH+fMlKpQcbCfIaYNwu3FP11PXl5AXYje6LXioh9jUfVsiCnPHnX0
	NgxBH6BXMQzv6aBP8nF6IOFNMQraBoWQKdk/hP7lrTkFryDqO1CAbcEA/vxP78buYYvfYBK805V
	juDIqLt/SKlRdVJ22mg5+JLMMRwzYUMuNNwPI9WqtmM+3R7/wag51xe+59zfYh3NpTLPeBJI0AM
	yVo4hyjfTQKWouTpldURHOJIrsU8d2oR0Hz8JZSj735Zd9O3kEr+nOE4/8+ednqiVuw5ifzuVqx
	M0aqGgTTXKS3lhyCh19SnD+GuLg9uhwI6k4S3c4G5+y+rfC9JLbqzkTvW/xF7qIhKW6c0FLzLLN
	g2+xBoOB/6wYEGdYIIZ8ayKKv6oVJ/h4BVQ2w==
X-Received: by 2002:a05:6a21:6086:b0:3dd:85a8:4c4d with SMTP id adf61e73a8af0-3dd85a84db2mr1401112637.17.1789668150742;
        Thu, 17 Sep 2026 11:02:30 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab50d67sm3678139a12.6.2026.09.17.11.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:02:30 -0700 (PDT)
Message-ID: <6a547919d40c858afcd4f8b9c7e970076711b30c.camel@gmail.com>
Subject: Re: Missing signoff in the bpf tree
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Daniel Borkmann <daniel@iogearbox.net>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,  bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Date: Thu, 17 Sep 2026 11:02:27 -0700
In-Reply-To: <CAEf4BzYp0YAbhkdkKJn1FR0pjUF3JXUxqXkZtWqKiSVPT4=qOA@mail.gmail.com>
References: <aqvBPVcN__UX8P85@sirena.org.uk>
	 <DLHJEZ0K0FV1.SCQLJJQNS1ES@gmail.com>
	 <66d3f5cd-12df-4000-8459-360ba57cea12@sirena.org.uk>
	 <DLHJUSTDSQ05.28VUGOV7YPS6V@gmail.com>
	 <ec2acd16-40e3-46b7-b120-ce9eec70e942@sirena.org.uk>
	 <DLHK013DCY3J.19Y8X3Z0RTWCI@gmail.com>
	 <9d668d7c-8f85-49ad-bdb9-5cb81fb6f60d@sirena.org.uk>
	 <c80c4e2aee9502d781fb52bcd5c0972ccd3bc7e4.camel@gmail.com>
	 <CAEf4BzYp0YAbhkdkKJn1FR0pjUF3JXUxqXkZtWqKiSVPT4=qOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-17 at 10:27 -0700, Andrii Nakryiko wrote:
> On Thu, Sep 17, 2026 at 10:08=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Thu, 2026-09-17 at 16:03 +0100, Mark Brown wrote:
> > > On Thu, Sep 17, 2026 at 01:27:01PM +0200, Kumar Kartikeya Dwivedi wro=
te:
> > > > On Thu Sep 17, 2026 at 1:23 PM CEST, Mark Brown wrote:
> > >=20
> > > > > Do you have a full list of the current committers, I guess there'=
s been
> > > > > more bitrot than just this?
> > >=20
> > > > It's me and Eduard, apart from Alexei, Daniel, and Andrii.
> > >=20
> > > I've added you and Eduard.
> >=20
> > Apologies, that's on me, some issue with scripts configuration again.
> > What would you like me to do? Force push with SOBs?
>=20
> rebase preserving merges, and add your SOB for all commits that you
> rebased, including "xsk: Use a 32-bit compare in xsk_map_gen_lookup"
> which you didn't apply, you still need to add your SOB

Done.
Apologies for inconvenience.
Andrii, thank you for the instructions.
