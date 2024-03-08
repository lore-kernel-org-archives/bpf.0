Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15EA2C699
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 03:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709869986; cv=none; b=RxvlOAyNvH223pnRyvQ/ZyI3rg7bYKuphHhUanCsLaiDwwAnkqMeOD0GtsOZPzsr03wYAHNkW4Z40js7ZjGFEMMKVzFFljHlR101Wku9aa2X8/Cn3mScLuJwKNQE8tQreQVcNeIFkyAEZ8/G0ni4jVSyO4c6TN/jsdwXv/Mfh2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709869986; c=relaxed/simple;
	bh=nQBQRrvHoysHynF+mTt73tPJEIZFv4JnnmX+dawqxUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGX+nNL4FnNIlPcBILiGHjRHwEeQV3GtbJGXcWodsxH5MtMT483Q7mVOitrq9/FdWrYd0+FrCDfIB2d0IHS1hzHIgKeq35pZ03OqyVDl0ra7zXHqrrCvs4M3Z8Aun2PWz2O4sY0XiIX62uGDZxxAW4TdwMa9HU8U6C9vCyP+CNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZRJNNsU; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZRJNNsU"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d995bd557eso927556241.0
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 19:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709869983; x=1710474783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQBQRrvHoysHynF+mTt73tPJEIZFv4JnnmX+dawqxUI=;
        b=CZRJNNsUOtD5tdjkkoBZyoKWBSMAu4OtuVhw5+vtKdXtrKvzpC2GUNkDbqppsdBwFZ
         LguluaQbh+s3rLRF+Xu9Lje9zEeux9mvnpdsL5U4+h4mTY1KDlZ+7fdC0KOkoCKq+atN
         2hqK16N4IQg8MCCj2anbRgJiSCNDxfzQK2bdqfBCncfttpyVi17B0vhDejLJzS6PDvni
         zDbgJ6Qp9dnkKc7NwjmP+ev04iEUYpdU4vWEJSu5EZ/KFPGV/Sgu8hC0fyb5o+bjVQ6m
         9OQaOdbIG5ilhuau2Dj59ZDAxJDylwJTR5Ljnj7objUUDX43k7jYtBXSg8vJ11T/mzz1
         N2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709869983; x=1710474783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQBQRrvHoysHynF+mTt73tPJEIZFv4JnnmX+dawqxUI=;
        b=VcNoyImTLftGWidazxr3hMbs98v8xF4U4UbB8colP4y6hymqdhG+dRTWa/ycBRrxZs
         VpboJ3dv0+8BLJdVSUtDxbc0futHoLBC5IluVLwxn/eW3JN3FAFh0NKeRShM54yVSP3Y
         uuBub1u2UlA5O+uWtR90MPrL3SYr3F7k4r3dmeXW+WkANKTRpvEHcEOJ/YARYGf2KFYM
         r3dnkDxYR1zk7T+zy3JIcvHEQ+WwbzdN1EFwPJCsct1vL6kqZcDUpK43T82dolmFRGHn
         ef2fnF5bTFS8Uef8j3s+LNT8qZSfFdbVzvMvKKEFkcppJR9EztHyq3/Tvgu6i5ITDs8b
         OJQg==
X-Forwarded-Encrypted: i=1; AJvYcCXV3pp4BELGASvpmcZ9oWRxCIS+b3iJXY6esc9crU05msUU2Bomi4wb3ftCV5lYJkUFavAV+3dFDI69QT/13B9EKrSg
X-Gm-Message-State: AOJu0YweMUF0bjhDmjzuZTv6hX4iA+J4mbSV4bBemRdyvncTGNj/t+Se
	EeSs72G5XMKKpmgFq49lY1T5wofUXIDc1Mh/ha68pbmj4nWdXkMDdlHv8J12fuYH09Ahoz22fEa
	UeLY9kf8RU+bGay3CTD4T2sqqNyE=
X-Google-Smtp-Source: AGHT+IG61gQBE4BTtN2uiusA9UVGstZeoSjwYUq4mM9Bpg7oK/SKNSofZ+XGxf44Saj6D6f5GdM7yM3YllcS45kykLE=
X-Received: by 2002:a05:6102:32d1:b0:473:c24:7b3a with SMTP id
 o17-20020a05610232d100b004730c247b3amr1936628vss.10.1709869983686; Thu, 07
 Mar 2024 19:53:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM_iQpXzAYFES62Cbj8PoGqr_OW=R+Y-ac=6s3kmp5373R7RzQ@mail.gmail.com>
 <20240304095947.GB123222@linux.alibaba.com>
In-Reply-To: <20240304095947.GB123222@linux.alibaba.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Thu, 7 Mar 2024 19:52:52 -0800
Message-ID: <CAM_iQpXKi3tYb+5O=NRi_C-eGCRYiZgk96=egFaKAPa3KX8joA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Inter-VM Shared Memory Communications with eBPF
To: dust.li@linux.alibaba.com
Cc: lsf-pc@lists.linux-foundation.org, bpf <bpf@vger.kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"a.mehrab@bytedance.com" <a.mehrab@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 1:59=E2=80=AFAM Dust Li <dust.li@linux.alibaba.com> =
wrote:
>
> On Fri, Feb 23, 2024 at 03:05:59PM -0800, Cong Wang wrote:
>
> Hi Cong,
>
> This is a good topic !
> We have proposed another solution to accelerate Inter-VM tcp/ip communica=
tion
> transparently within the same host based on SMC-D + virtio-ism
> https://lists.oasis-open.org/archives/virtio-comment/202212/msg00030.html
>
> I don't know, can we do better with your proposal ?

We knew SMC and it _is_ actually why I have this eBPF based proposal.
Sorry for not providing more details here, since I just want to keep
this proposal
brief and will certain have all the details in our presentation if our
proposal gets
accepted.

The main problem of SMC is it is not fully transparent, LD_PRELOAD could
work for most cases but not all. Therefore, I don't think introducing any n=
ew
socket family is in the right direction at all.

(There are some other problems with SMC too, for instance, it requires more
than a 3-way handshake.)

And I don't think there is any conflict or overlap here at all. Our eBPF-ba=
sed
solution relies on the existing inter-VM shared memory, no matter it is ivs=
hmem
or virtio-ism. We don't propose any new way of sharing memory, what we
propose is merely using an existing one and building our solution on top.

In fact, we believe our solution can be on top of your virtio-ism,
since it is just
another flat memory region from our point of view.

Hope this helps.

Thanks.
