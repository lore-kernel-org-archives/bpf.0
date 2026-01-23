Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C634B33D6F8
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 04:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769142428; cv=pass; b=KScgLhxEkHulZT35BSgTkVff8fJN7VIYl+Hj74wqfqimi0nkEz3XV1hk5gcc5bE93tt3kfcE0BxUKfdu6uXzWhImAFF0bN3OYVuc6CESCTCs8SPR6MPp7yu2FJZ830pUF9WYl8gYj+5snGdhEa4gXYPV+1XaifcwwmZ9BUN772g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769142428; c=relaxed/simple;
	bh=4sBxsemq4ZTrHq+FAyv+6ME9CIWbSydS34Y8si9ZBoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qviObQspVFaGeBGufVG5UbeXyILmj92l/fTcz+pGxZvenLqIvOWn5XhdASJGgJmGCXsOLz12YWc6nQnYDBLBfTb2QwQM7yqidrNfKvnpNrXKJhcrHOAddZApJ8GeBFpZBTiJyo81/TeWotHeFsR7Ngs95wFuo1FodqtdY7e3tXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWHcJDQb; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWHcJDQb"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432d2670932so1694558f8f.2
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 20:27:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769142421; cv=none;
        d=google.com; s=arc-20240605;
        b=cBx6zlfRWLvRSubSVbSHuykfwCXeOGq1BpbdZnyvyD1NcJ97o2cZry3nAdeYw+OqUi
         gRnkKS+OhmGvQoywBi4vJqYLOeHYV/OWEV4JV+Z/1e0zGyVUQtMogdiN9/XtIwC63zIA
         xwVSL+YP19nYxHDef5Ibf8g3jbx8VHixc1MeIrc8MleJwH07O19pjQXL9MHfuQmjJk12
         J6svH52kzABgy0o8LQUMzX+0toIlgHo3XgxZBlcKZJlW/ei7ueE5eVI6UuLw2U6u7jgW
         MZh4NQNH5GL1x1CVn+ZUt9peLhSbx6QFOrToQzbCyI9TfgojxCO+9xzygkbPMPhaVgpf
         mEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7NKjARbPb2eV/gjYap2fSJDcxGAh3MDxlqq7QLpaBCM=;
        fh=fgKuWAwrPA93AAgmAid+ntX61zo5emBWKaUHorOCgYM=;
        b=MfzXV0PVKo3hEDxwxSFkX1ZR+bBDGSUuAJzy4rlmqIED2dOU582dmosWoc26DAM5Wy
         o83OgFakog/x+cweT8UTOXTkBmIUxqeLDyP7oiOXe4JC7oXsKr8IMw+FlXM5hKWvIH8A
         JVDXnENBRW2OBvUK8hncu3iQIahDmsavo3IyWfNgZON8ir7EZ2PynP/7qExYxzmllZcA
         zgcVeegp5f5+5shpw0j7IVR13Y3i1bbJbazu5g+BCTsXSE0zSxDdYmmkasBoxKwYU7CJ
         zPPR1Ri7ivJOo/8nkq8OtLZR5TM9KkT2Re1mSgVQbD8Nrkt+l2TmSOXFZYcWN1nd3KH4
         CbPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769142421; x=1769747221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NKjARbPb2eV/gjYap2fSJDcxGAh3MDxlqq7QLpaBCM=;
        b=NWHcJDQbl3vInUqc+X8KJC8kxms3tefzEsQEe7sd3JKi3sFIa47i7SeAbttHnkWkRO
         92oMIUBE+WYK5b8hVF1sWVMBLdPF82Mo+Aa0vQJAnyN4sVvA4AkZPoRfXX9bYjy4R9+M
         FvmKrgkVSnuTqieiQcswFNyfIPbwNfs+BVol1xcgI6B1HIf8F1avG0+88cfyq1NgOIwm
         v84OhNeL+Hm2b0sqQyFlAHYhvzku3lXobZCyzoLz1ReULQG4hfECeRVfUIUyjI3RNVqL
         rj4Na5SeazUBlBjQY8OqOvOeFKWnUk8d0xif7Xgb58rvJPvRJuMJb/xrScHfSquldl+S
         pXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769142421; x=1769747221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7NKjARbPb2eV/gjYap2fSJDcxGAh3MDxlqq7QLpaBCM=;
        b=ETZef1fG6engjQUll+atqXUyZYaC+rFz1wJIUSrmEHizeCvIvNtCtJXumIDvnK3sRn
         UdfMBmxnoBUebPAf1sWuUZFM8x6yOvcAL3tN6I1mDCMMJ8bW39UUp1ZLaIQxr9coTV0v
         OZ4UJmB7T/swZvucSgVazAdw2c2LRBKSVqBeVHfyyzw8801kDY6G/9GdeYg7jSwAuapP
         T//MKrRjwrQY5rIwZaVPrS2Yt7pHjkFL+5nKkh846tN9idP/Sb6KgMVQ5XQr8ioxI3Na
         mDGiG6RUVkoiTNj9SEV3U9z6U8WKbEp+dlz6uUh16HFQFUW2kKiX1z7EME/JUMRr0Lvx
         F+mQ==
X-Gm-Message-State: AOJu0Yz3nN/YLqkZvS1ddsMOyW9ioKYit85BZ+ND44eGtHYLaXu8PYOm
	0t9z5XWHP371tH6SZ0sXmxlu7TmrYGu8xZ3KBxhFUB0CY/BTAZ3y01QFc+I49gvjAOQY+g8CWqn
	F4VmBYOETeSsHUCyXGJFWcTmuMDD4p7k=
X-Gm-Gg: AZuq6aKWin2+2zRkW52gmJ4UdM+u4FKP5EvZ8mCFyPl5pafdGSE2uSo+pze9Nov/CmM
	rOnTirqLuGbgX+DslZl5EadQt/aqm3XhWtJhUBdeyBLJTc1S7mxWiGDTtqMsYOW5RmtNbIPw/Ve
	URql3gD38xeBcdNviWDdVkMg1gr46CY4XTQVs2QQrtS2kkRW1669n/4GlpmC83jiW/85cjbzNhF
	MjloeS5pEpKnhnuiJNaViUHU28dfzCbaA/o7dlxlkNYSR6LckFuYCDE+MQr2ysNoIBUu3MF5rQZ
	QVPx+nlQkeHxfaYKYEOqmK9N0Zk+3TJYOsATgfH4VZ2Dg0b24UEiBmYUa2HMZgSP9mY9dpIo0n/
	q1sTFwEuH1Junmg==
X-Received: by 2002:a05:6000:144a:b0:435:9653:e151 with SMTP id
 ffacd0b85a97d-435b1587d3bmr2703555f8f.3.1769142421272; Thu, 22 Jan 2026
 20:27:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121135444.187001-1-mattbobrowski@google.com>
In-Reply-To: <20260121135444.187001-1-mattbobrowski@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Jan 2026 20:26:49 -0800
X-Gm-Features: AZwV_Qgl3wxnb-WBVCZ5XZXh-PTRW2OSSePATd2DISuzFe3X5adn42zsRAY5j9Y
Message-ID: <CAADnVQ+8f1mK1+L9S6uDbo0n53zs9VeUhZr5eTg0+jXppRAhcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new BPF_CGROUP_ITER_CHILDREN_ONLY
 control option
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chuyi Zhou <zhouchuyi@bytedance.com>, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 5:54=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
>                 break;
> +       case BPF_CGROUP_ITER_CHILDREN_ONLY:
> +               kit->pos =3D css_next_child(kit->pos, kit->start);
> +               break;

There are no users of css_next_child() outside of cgroup internals.
It's a red flag for me. I feel there is something wrong with
the use case. It should have been handled by the primitives we have.

pw-bot: cr
