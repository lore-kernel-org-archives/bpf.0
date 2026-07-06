Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B152DEA68
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357297; cv=pass; b=C1N5g/lI0x6D2kzEC0c2Nbtl9ZT+A7KKmpPKBp14FRCG0fFpZWDN0pnJxqJdRvRwFmB4A0zIquQwrIFUkFF/yyWDbiCiLY7TW0PidfqQMqzvkqYmZzl9ozhUDE2lMRJVny3u7BhkqgxuAMWcGds8lXj1P/ZIhpswZ1f4+RQbeKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357297; c=relaxed/simple;
	bh=/fbiPozIgE/BcMKR8ypJKRnzXzWLVslZg5WE58Fd4gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWL58hmWK9KzipHG3EyZFnlM70bhPM9x9sMI2Yldm49mSHzjD9jU4sHMkLqsuviHMFcf5tdDe0GTMCiY/unVJZ3v7LkL/lY/lZOofdX8vKgTmOWg2Mb0EYv2Vknfb7uJra0/nP71GPADCWQ86rLOcYezISF1E8dvbuGubZYHlzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BJrZT5L4; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BJrZT5L4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c7c61b5292so47805155ad.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:01:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783357295; cv=none;
        d=google.com; s=arc-20260327;
        b=s6uUZM9h80H4uYe7WD4Vs2+b5/TlcE73JVI1H6qasQFSpQIVhCg6J20t33jTIyz3+X
         pj47SuPkeQFUqQUVH54l3ezI3Ci3jms5HzVq74WnjRDGpwuJnxp3er/ROXRmAqR4DTSS
         l35G9K/6EVTuD847dQxVhUaBi0chus8+wyV5uuowjVtX6HiP2E+jwSCbtZhdpiXSSWk2
         04Ll1I6+vFKC7g4ga/f6enMmi1O7zdbDPVuEE1qxwO1960VKX+dr9AhERnaS6trHvYmD
         y5HCfUQfQWV8bLvi+sdPQmMy0fYuzdwQvOv/oTmnaV0UGu/y+FTY8h7FJNvfl2fVw/1x
         PImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zq2b1QVorb+bhiFECEfSOsi7qpZoF1nziG3KnKBTCwo=;
        fh=eRKX80Nt1daTozFqmWmTibGxBVez4gt0Tc87wZvX5Es=;
        b=JbHf3RnUsiekgbzjlwxvMrb4xPcujvfb2KacAgr78yQ8Wb8wt9v9mQP3QXPF7+NY3m
         A/A0hULyYtgAJPOnO55qDAF2C4VndtglLCXfhlBoWfuM179dwrHxMhohS9rn/rQsP+/6
         DH8j0vTYvD0m0c/U+Bz6mOGSqlX2W/vwmASPE4eFWibn9Y6NVd/NDzLZUQjWLwTyYG4t
         sYToz1yEU9T8Vrl+YTdXmBF/JcX1FJxj0FbVJ0GXqK9EC46JeGaCL/l+REmxaCjRZhTo
         lwFWHPGVX5P+M6nHswtkKpd6Sy8srqF4UZ44CFaIFkoxPAhw/4GldT//HeucHw1jOl3d
         PBOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783357295; x=1783962095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zq2b1QVorb+bhiFECEfSOsi7qpZoF1nziG3KnKBTCwo=;
        b=BJrZT5L4kB8+03O1XUB065bWaMO6CeNpCHtMAPoW8aMEgEncyMUoesoamFJAzo6/vr
         xzFX2EKrRK/h1VpYHmxo95Z6xAt4LI6vU5Gq3nLhekeolmZUWnmdD2+sCYDylDZfqh5M
         ef40H339QSNtrNlL9Zu78iR/jAevuekNXrQeZjBmko3u4f/ycffJa++AqYP/ZApFPja/
         S1xxHq0bYnjdr1w1JLjP2ywC77Ja9+/rt2xuZk5JmcQn4L+pS+AHbpfxthWxT5fSPbH1
         LVdeJvf1PgP0w2/2UJI+L2pkYV7IT6zuoAxUwy1nPhkVmVl0sZOePgCyfZXUa96gISR2
         KRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357295; x=1783962095;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zq2b1QVorb+bhiFECEfSOsi7qpZoF1nziG3KnKBTCwo=;
        b=kFfN+BbV1x4+j++pyatdSEmpDeFY3P+yMSISi+XQQwNBW2NFi9LRwMIHnln0r7ipHn
         kviAWNzH5Mec3Pma5oe93n2z9I6yfkNc3zhMZnaUOCFz2dLyAPwhwv8bKoeEB6YeYrm+
         NCoOLEqFAybP9ETXyyPRDdKKFL6yYNnx4TitzJrZ1Khwi1eCcR+rRMBYLlMC60sHepDz
         i8W3cMB/7w3zTnORbyw6G5sH370dt+CJtzMw9vZgGYlhtxCYHr5IsVWU2MuV9ojhWYp/
         /C7xtIRosl9QnFSjs894kFu3ziHNw7UtUaJem3dcIX5pZgrX0EbZWIMmF1e9+LsVu8Or
         t7BQ==
X-Forwarded-Encrypted: i=1; AHgh+RpZ7adWhHFmI4Pr/ul3XZykV2jaukvBYNZ3tQ0q+tlJR2mVAtIM7OqkYzeKkei6PyKJ/kI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx83ynTz8ch+nR/aiVqWWjtEU6cMvM8EqkVIjVQQwNGuXJmzScM
	wfezyCev5svr7ayy7j5en7vBOS/uKzDSdCnrViGq/hVwbVNdECgyQiZx/YGMIuc44VEsPEOF1n/
	qO+2EF+BWLwaVEfZBS4eaV4xbTnS33EJXXT2n55c8WZG3oSbO51x9Cw==
X-Gm-Gg: AfdE7cmfCD6AYC7VvLVHf/QJc7cT4N+hfLqRgPC6aChwWdA5pz5e6NjeunKOjrOts5f
	aj2MQfN7gu0xPB/+ePOeyLNtxKJJlBqoV19a2cfnRc0tbAR1hL5/9ZOrhgupLMsmhOixMXDXhbs
	tTSxZW6YfdU7DLss67rE/ibz+nOAT4lxZGnpbzThnOUBMoKjcQKeqHo3yU+5zh4aazRutQZkBAc
	qnY7wJsrilcWDLudlZRM8oG3Acki6jOisrI1zGYsWTg057KMzpbYNngYCtLPBf6sCY/xJLGXmxb
	g3nMbk8=
X-Received: by 2002:a17:902:d58f:b0:2c0:b6c7:2271 with SMTP id
 d9443c01a7336-2ccbe607239mr17075695ad.4.1783357295265; Mon, 06 Jul 2026
 10:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702143605.252797-1-daniel@iogearbox.net> <20260702143605.252797-3-daniel@iogearbox.net>
 <CAHC9VhQD4RHsGiTMVCCTN+eB71-Ueopke8XghExpNJ2PSNa_jQ@mail.gmail.com> <DJOFY21DYUI4.19WKQ3NPZ4H5R@gmail.com>
In-Reply-To: <DJOFY21DYUI4.19WKQ3NPZ4H5R@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 Jul 2026 13:01:23 -0400
X-Gm-Features: AVVi8CfE0QwDBed6yHQcGtrwFOqh1sJ73kXaa2-AIzBqCn9zlWXgtMH2cudzbRI
Message-ID: <CAHC9VhRk=j4_cNH5v+iCvSpJXz2g=dTK_+1O-kgT=E+OESENiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Verify signed loader metadata at
 load time
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org, kpsingh@kernel.org, 
	James.Bottomley@hansenpartnership.com, bboscaccy@linux.microsoft.com, 
	memxor@gmail.com, torvalds@linux-foundation.org, a.s.protopopov@gmail.com, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 6:33=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Thu Jul 2, 2026 at 3:05 PM PDT, Paul Moore wrote:

...

> > With this patch, even in cases where SELinux will prevent the BPF
> > program load operation, it is not able to do so before the process
> > triggers a potential sizable memory allocation, opening the door for a
> > local DoS attack.
>
> Not true either. Worst case is 1M which is 8Mbyte.
> Not even close to anything DoS worthy.

That's 8MB in a single allocation that can be triggered directly by
userspace.  I suspect most systems allow a fair number of processes
per user; that 8MB allocation can quickly multiply into a big number,
especially for more modest, non-server systems/VMs.

--=20
paul-moore.com
