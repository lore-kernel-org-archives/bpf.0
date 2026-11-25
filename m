Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795571943;
	b=GNapivwIaFwcgTgQ5m4ZuAbQQob4tnZ8aB48ZYVobUxQ7dDgk+kS/DVn/c5ppJKV17A6
	 l8AlqRS6qClU6yL7Gkr/JTeajFeFdXIeuErMyBTmBwtQXCzE9+UZVZRkzVxPbrtFqDIWg
	 OytcvJ7z8rfdnjzYnGdHniEE4nomf2HPV0gV7euk/s7XwCvdru+PFcIs4qCil+hvnTAIR
	 QrEGGw8AMu9pCJFhhlwquzboSxOjyoKOrxrXCl6QwQIBkeMlGz7jZbPhbFKINumwQyZ4w
	 YwDs1ZB5EWwpx51Nz2UeuCi/j55hFMlQ//DGu29AyDsmxwAK7yNXNOicTPuVvdZwn+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795571943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=WQW21BATbZ9l2kqtcswgu+W5tZ5971iz3LnWV9zl81Y=;
	b=y9x6G3QuKSyuGmhJqbtfiYcGSqK27rrlneIFJcH8kfd/lEjfhn2DGyNhlrIRAzYcC9D6
	 gIUUU519csUCGYVfL4gKQXDRTDzjQ2yalsthtAff4mo7J5+gMif8TzCEeESDH0iE56iE9
	 FoS8fzKxMpihr7wbtbvRqyxkfhutHJibfU2f1S0uAUOI4eiYPmsyn+oWD2GRtVcIgPeFH
	 7fZrcub0lWWjhI7WeG+TTksmgMuH4M2QqIYt1RaMchvNwC/XXQBtwiVQkiPzNutttxEB+
	 g92qIN2biG+UpYxVEUUPihcvvX7gYYVswt7ZWdaph0yPwcNxXV/B4+24EGB/j6BX0CQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="L36/WytV";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.71
Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B56606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 01:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5B56606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L36/WytV
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-6b86bba7613so1745772a12.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:59:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795571941; cv=none;
        d=google.com; s=arc-20260327;
        b=R7WzlVsXDHfof623LERSaJLDLMV8pjoWr5swjFCBRksE4bSrymCKJBjQ2QzyXt2dW6
         NJjym2s6G3tq2bslp/wRL2sk/iksJa/MtJ8d/Sp7Kt2/Hjm1yOBE6wWLZRJcSTIIjiYM
         V5aN7dYDE5+GSl/66Zlbc5isCRfF1MUZznjZ1NoJSrW/ZYjSZ9J4WMO4cTKomM+NXbVJ
         FhkjgeCgizr0l8mfFYRB1IrKTNcEEtBOmSpLp2T+VZjpN4LGZcfpSCZtVQ7SGyS1JVIL
         /F5gAuRmJ8Z+jUZ2+sjFLtXPoof06uQIi02qbIb7TfXrhv6xTYXD6MMlG26iRy/ZoyOl
         A5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WQW21BATbZ9l2kqtcswgu+W5tZ5971iz3LnWV9zl81Y=;
        fh=P8Gh5wLwg9GqibOZtXAGdbn6fbYEwtuBf1cfeweSKYI=;
        b=FmLJVZ8bK1rYxF66UuRU8Oo4gJ9kLEif2swEGdJe4WcBDK2/PRiWP/gK1jcTXhUu/8
         dGTxRkl+X3at20SlSAfkQBbVt9z2rjxHDs5Prkep38ZMreuYjD7hF1S+zsaTPsRZb0mM
         Eks341CokYFd0jDHavo3v77irsjZsuTmZ9hrRsoLN+WeuZGpcm8zC/WzfS/hphvdYBs8
         XMQYgGyX/onrVVKhrDehvChjpY57LYE0c0qyGHJxf6mKnQw+ZPkj3u4UnrUlpvuXT+CN
         VtBuszfydny9y/oxW3NgBgMHzMGzbW8HNKVLVi9d926l8s2GwWGHhHOdhkW0Xh5drURI
         F66Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795571941; x=1796176741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WQW21BATbZ9l2kqtcswgu+W5tZ5971iz3LnWV9zl81Y=;
        b=L36/WytVvlC9Pn87+HM2NinzjlmizdMqXBUMl7IpcCAe6Q2q+7L2YxGWJkTpMhuduJ
         31GWllf04SK7ZwYyaAF3TGiUnRjuLoeUwK/dus3Lrg6XSsbwpL5szUSuBps+4uxJRS2g
         hof1kHF88bnvHESbLWkBQaoWpoKiUD2PyHyzU9V3WApg1JE/p1YxvqTZb207HPS1x9t4
         n5eShDEZzpNp7u71Acy4g54QcN18UyJwcgqoeHM16I+YycxqJhEZeUx+nxWZtyrsuNAw
         pqyN1BKYqHg0dqMlHdsqtjBay/aJIwlQylS6PlFoUpzSCpWZtaIqGhwWylw+ZtUKC0MO
         ulwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795571941; x=1796176741;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WQW21BATbZ9l2kqtcswgu+W5tZ5971iz3LnWV9zl81Y=;
        b=Yt2NvUS8nIxO/rtThL9kFtGcPz+iHk+UfCCmiydbBujFB4ZYMhWZZ6Jxi32POSEkAW
         Sr3lwMcDyGSM++rQzDNKIPtG+PmxzaO24M2ANfLydnrfZjeJPSKh3ynCjuWdTI557x2P
         /e9cw4bS2PDHZKWjV8vTo6csj2fnlXSwLKorVwdpwogp6xuzGSy219EOgCls+KjvZ1Hi
         DSee8b/9VoPSWwTqworuDTZHrwT9DH50OLKFZNGtfpfm9p8VkuhirpavJS0hJ1MzUTJQ
         tEDP9/2qUdciUIItwTJzFZL/ZuTMAyLKssBYpXRpeK6JethtcaXMMTaM1xk5FVZhmxHe
         c2Dg==
X-Gm-Message-State: APuU4Z+jO8nmb3M76XtpA4iHuWR4nj5RH7ANQAH5tTQgMBbgz0oJgZdu
	w+AX9RcWlEOaehJvNBzk8+RtxOkSUhgs8UPbyf1wPjsb9a/cq4OQw+FeVL+M4XuJI8VCpYhfmZy
	GjddBTJHBkgcQOQkh7c2d6K7V80X2R7OfPgRcWGaSipHc
X-Gm-Gg: AZFdTZcQkQqESOehBboI2mXC/QdCV56B4lar+MP4LpLl+JQi19Czg8qFbbRvWTSq7oY
	auDHkR9pxJTElPpMWm65IRNHe2Ka5u8zItZLQY2boQmuu6xwHFoKjarKb1xuBMdAqesK6HlOE2E
	SyPwYl4QpYl5hk7jZN7HCLxSW6DaDh/7uDYJ0HdNScKZNPM7zokVtHPdNMH56YglTCXeewaf7wN
	BaTbg5ExXnDWQugwBTIxRAq51LAnkhrGAEPInj2EUGA8d2OmIScC4VZtlEwHSvFZWbC/vHHTdxB
	3xhM30W+IggCFbgee3m3FxUcI5PblRS09Huj5VetVO6/6D1zzS9XHLw5YrOyRA5rYApiaDyUuTz
	CiZsIzSd4qdRIrkFZUFZTzbdVbiMdauz2D6jh/Jy8vDfq0UrvGDDZJ+XcxNeRCzO8h6Taig==
X-Received: by 2002:a05:6402:ea9:b0:6ba:eb4c:487a with SMTP id
 4fb4d7f45d1cf-6baeb4c48ccmr3353474a12.22.1795571940941; Tue, 24 Nov 2026
 17:59:00 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAPig4syGNH7_LGZrHyQismhLZ9zanbDAAkwjcWtiFcWfpB6v0g@mail.gmail.com>
 <77c60169-13c4-40f9-9657-2f6ac67379ff@gmail.com>
In-Reply-To: <77c60169-13c4-40f9-9657-2f6ac67379ff@gmail.com>
From: =?UTF-8?B?5rSb?= <wanghai8081@gmail.com>
Date: Wed, 25 Nov 2026 09:58:48 +0800
X-Gm-Features: Aa3M54p4yZgaeY_DTatP0VruZQSz-3EYMSlcvnI26KkG_kMUm9Aju31KYclrOZY
Message-ID: <CAPig4szH_utJ=+ZmqJoONtM9fQ_Ojm9BqSPmrz2R2oMs-oL97Q@mail.gmail.com>
Subject: Re: [BUG] libbpf: bpf_program__clone() uses a stale module BTF fd
 after object load
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for clarifying. I found this while testing. I don't have a
production use case that requires cloning a program after
bpf_object__load().

I tried adding an unrelated MANUAL program to see whether keeping the
module BTF fd open affected the result. I haven't tried marking the
fentry program itself as MANUAL and loading it with bpf_program__load().

Thanks for pointing me to the veristat example.

=E6=B4=9B
