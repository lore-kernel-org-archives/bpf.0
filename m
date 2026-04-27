Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7494D2D2382
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777255821; cv=pass; b=VJrhJTfXLHFG49zueZBE/9jav0T7N388dZo4Phv5MPsvqmBJGmZK1/aVvofyIng56Nw/K05JNfSMjLMA2jM92VJxK1reYCFVr4VEnYjdzo8Ry5Oo+e9Ho/0zli7TMb0xcuKuLZLAScJ9xIgiMovbuKm4yK1ceqtIr2MYXv9CPe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777255821; c=relaxed/simple;
	bh=jkK8/0biK4bjAlR9voiM+zgN5Mx2RVeA93tFOSCHKZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgCXfFmEyO5vQ7I4bwbvqrlbJqMIBiv5dRx6rHZNQRmymbDs3RLXkuHI/r62++UXJVi8i0pYfUOP41DDJTF06/OF5poDsUddOMDBIHHiuQri+FXmyk6G4uAQKi/ea+IDsLvsdGLu7wz8gzwVU5+oed3tDbk8sIQtGyUjUK79ghg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mtl3TYg8; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mtl3TYg8"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c70b5594f4so1069828185a.1
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777255819; cv=none;
        d=google.com; s=arc-20240605;
        b=Ya1RcrVe5gkqOGY8dYdd3+54mRoCMwlsAR48eBzRlyT7kAhvD9Qx73qzeMFiGUll2E
         Kw/9PrwWmzLw4Vh1D/1B0VzClonbfkUCzVINSmkPIjRRtJBfpp4y1YGw+z0wkINuDa0I
         fGNFLaZOyzZX7UTjE7pbOu2HYQXrxZ9z049UukGAqxXmvoK+OW3hn9fTTXzjMm4/LHpw
         1dHhHPK6JhSK+88OEbQyjil8ApPVOj1+Vb21SSgi17xHSo5TilM+G9GmGrej+Dkb57y6
         XKSqS4qrNO89eGn2HH+Dk+D7sOQ4SKusg7kIvz9faTAc+ETltgMybyfIT/7y3slDX6fL
         Ws6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jkK8/0biK4bjAlR9voiM+zgN5Mx2RVeA93tFOSCHKZs=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=UhmYcznjHa+Q99OipiMJ80CCp3K7a2LgR5pwSw+DyUJ4E5mB0UgYasvhVyGq5ir9vB
         dQAQQVsyvOvO0ClUzAMJFrREb8f2JzcVwxjCYDirXh5saS4pFAlV+OHTKirgSe8DNXUE
         J5BQPpWO984ssSrs3YNu92aeHoZAAchuU1MCKzBiO5KFwVzfQeALcuqWQrmUsOM9h8JH
         +/oh5AwK1KWpuMU09w/PTSFy/8vGb853oKrUpdB9f0bZs0lS6Cxyf3bG5lDMoat/VrqS
         V9D5VoBMq4VBsr4SDUg0zBgJQCxvJUNvjem9nst+P8rb/4AKgQZSWmtQFeS/LqKfRN73
         iVVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777255819; x=1777860619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkK8/0biK4bjAlR9voiM+zgN5Mx2RVeA93tFOSCHKZs=;
        b=Mtl3TYg8rmLsovNPTT46hHyHQK85c92Leow3TrbE4/m7SQiEL27pJ6zao0gvqXcrlu
         yJVJB4tog84mOluF40cSr9uc6n05nBrc4msb1IIq0e/sHqrJh0ExUuNCuj77pK3a2jor
         UZX/IBgYu4z+bj3CxmQQc/0QtVUu+BNIKqRilf7efHs3Wfn1LBUdFI8W+/weZtBwFhMt
         cCgCZcYCfKgcb+14QOobgWquTHRSj3E2/M9P6FT0G2iX6rBOmnGgunwr47Frq5BZloxt
         TFyu8mGxYJtx039rogADWrDy9fCOdr9MoZtbQU8mrzZ1zZfY/md8soXSYISmVYV0sg9a
         76qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777255819; x=1777860619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jkK8/0biK4bjAlR9voiM+zgN5Mx2RVeA93tFOSCHKZs=;
        b=VrhCP/4D3+LY9fNB0dFF7YntAmQLh732gY1Jm8HUemHsTaMKo96TgAPngbBNF4PH1T
         0gw1mN7RKuaXw1vphJkCq9y04cxNIPoxT/C/+6QFCQfY6m0V1XJnac4tG71ohe0DcAua
         XoH0MKML13bg5c/TGTTCw9THKg5RiXQh4hwowRoIlwWbiFoSfx+fuNJY2J6bKICk2XND
         Vt+Gva7lOvcUtMKh702cp0/PNf9R5sZHwqRLg/GWfInj6dyCXopw7CoBhQiJFMT47tIr
         WlNwEFft5McQjfWKoCiCZr1EKg1HoNE8oNO79o/FID5toY+WAVfy5OdBOn40m3FCAYm/
         pwLg==
X-Gm-Message-State: AOJu0YwlgSfID+nlesnq7Tr9YX0z1gJJt8CN47RzCo7WsQYjUFGbVQE+
	3TJTMjvtTWzd3sjTCVu9K96AOj/3Bfjfj19t1mvod0UD8LAz2doHW+kOSQDz8DSiMoeka6/0h9e
	n1MNKUD6htUaV/CubZCONvrC1lrNaMxA=
X-Gm-Gg: AeBDietL2FR4PLBs+Di+vFfKMgRUvm2GXu61ONOWOOSYaoR8JCqF579atxmB0OG/vNh
	+SHuWZmVClTzy4FmYvE8A3ysoKmFUiDGvZiR9yo+Is3KuTdRgV8VLqRZbOhaLjx87sCTIHk6Khc
	RunuefyKEupEV3xGGTG4hZ1IEdZXgDC33WVjFJnH7F9TRxfYWdWEot2BlQAb5yf5hJQFfPh892p
	6MZteeYzDnZdyPAinfjgQFz+YOF2eOoKsWkOce/IYp8QFuV00X3Zhhczkxndi1fowrHGBhvIopm
	4LVg1gQyARLurA+YuK9DfZDFkneSY6o2NVmQvkkXJcjOfp2cZoojwSH+O/uoqA==
X-Received: by 2002:a05:620a:b55:b0:8ef:2118:aec4 with SMTP id
 af79cd13be357-8ef2118b76emr2293526185a.27.1777255819419; Sun, 26 Apr 2026
 19:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-2-dwindsor@gmail.com> <20260427005655.9B96CC2BCAF@smtp.kernel.org>
In-Reply-To: <20260427005655.9B96CC2BCAF@smtp.kernel.org>
From: David Windsor <dwindsor@gmail.com>
Date: Sun, 26 Apr 2026 22:10:08 -0400
X-Gm-Features: AVHnY4JtMmIoRwYCWQQyy2UV8X3pukhYq4UbkG2ZS87EeIsJuPnzIznz6GhYXN4
Message-ID: <CAEXv5_hCV0BGG=gDN1kupuhe=o+wCojTW32-R=9J8zmi4SR6KA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 8:56=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
...
>
> Can this result in a use-after-free of the name string? The name__str
> argument typically resides in a BPF map.
>
> Since the filesystem's initxattrs callback can perform disk I/O and sleep
> after the BPF hook completes, what happens if the BPF program is unloaded
> and its maps are freed concurrently?
>
> The name pointer might then point to freed memory when the filesystem
> attempts to write the xattr.
>

Yeah, good point. We'll kmemdup the name just as we're already doing
for the value.
