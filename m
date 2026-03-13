Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4B733D6EF
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773370207; cv=pass; b=HZC7LlCEcwv2I5GDv1zIzWtami1/dALQTzamp2twwTLx/5HeVO/5XHQV3NLvkAjtMV6F+7OBjLZaPCMI9rejdLKhIGnqTAB4KYnVd8m14Im5/dx/Odzsvv5gR4x0PWVIUInXu7A9sXDxGuKDTbI/GLOdxqUmp5QHi7fKZuVTK4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773370207; c=relaxed/simple;
	bh=1DDAUTZZs9nurII5sQuxTIy3I1smjx6u+1ntACDvnN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqeBd7ki2+8xL4ZLJIpdAhLaRMLJimIT9WoqWdS3sNn6/gkvVWNTxjrYWUQXpb4QXzUNHbShRYMYWX1gvmwJXO0q5dkUwD/bRNA8mHSOmaXzbR06jqIMfMw7VeF1mke3DJ2dHuI1h1slCHqrdd0kdSL+0+Mk7ixfCIrfjr7VZqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+AEaGjf; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+AEaGjf"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7986d231b3cso43087187b3.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 19:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773370205; cv=none;
        d=google.com; s=arc-20240605;
        b=P38ti7z4376bwn1XSouiw3V40/0BVSfjyYXb8lp+pofTDZEW3DGJbmY3GRLqsUCg1o
         9KO27qLuxjbykYDmA2gGkkBcAbDev7M51wWfY0zHzd1/9MpfIL2Nsdaaf3VtRhT3DrAs
         161T8ps2KJeX3Y1EMVirT8KRP5wsy8EtLr2hL/kK5CZU9bBblfN7CGoagwoEFyTeNGtP
         aZK6WHU2feClVQWMiI17cvGugiVTMrDiPEYNiBLm3B79I9bHxir/LG4gdNgJXz+G3FFO
         xTh9zkkl6ahWLDolfds+ywgE4AlK9VdKnA99oNX3VhIrX5orNsS7L9yHiQKsSDWEbecq
         edkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1DDAUTZZs9nurII5sQuxTIy3I1smjx6u+1ntACDvnN8=;
        fh=v45UWFWk5cnBPANThBvn4nmYiLhpC/UbGkLeJxLOA7Y=;
        b=Yz5HaZmWfMUBJLsezxVNGwR42k5dSnP1A3ZuTJKgfLbGm9mURdFJKkHg5M+wht5jdI
         XHFoqm3yRjw0ly2khzXQeqLWqHQLdMqcM3d63gB7wiILR5c2wmQx0uW3GySyQADA+o0j
         hl9jOVgpr768sasWjTD/Wy8Rrsf3ESQ80XUMSMQQcwV3EsCDB6HRFTSoyIZaxzO7RKTn
         UbrCNrBPN9d7spZK56IFAhZsz7YVbQdr6RtcuItI+g8eUeV4kqfJZuvWdDJO6sknnJzM
         am/Pn5Xdh2bSO0dGXLuMQ8dG+5txEnptl4Mv7O95Zf0RbsTv6HvzshmqKf2PjONdJeCZ
         G7Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773370205; x=1773975005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DDAUTZZs9nurII5sQuxTIy3I1smjx6u+1ntACDvnN8=;
        b=C+AEaGjfdrInamjQjc9HyWG9UqSDlwsmvatT7cFDhFC+r0s0pR1fMVINF4RE7fQlFi
         thCoJZbeD31ojUpjoBhIFxWeR5zMCR5K++3oonQcUZuH9+J8TTU9q1h/Uf8fWXUQh/Ns
         /38xv+qUCKoLhtTbVKZFO+QCKsx654Xnk9vxBXXbSc+f71sunuzmDJ3YWs46FUcluyCA
         KJn3pFHJXKPAWSatz5rfFI5GY+umbw0gPtaDlJlX33yoMgd/DyFohgeYc9Wgqny2wpgc
         CRAwlKycX5rIPeao5yeH8FXgE0h6lFKY0qmXUGsfMzOjcIR9kxyw3m1e0k7DJM68dc8F
         OMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773370205; x=1773975005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1DDAUTZZs9nurII5sQuxTIy3I1smjx6u+1ntACDvnN8=;
        b=BnVlK8rl9QYIVJ+yFVoiKzzGblxuvnoGVvJsQTHUTbCNHRjVMxb/B1lxpJjmIJyich
         v7npaWxodpmIqlQF8eefSuUB6Lh3XHutAFQC4moa2Hlz5W1fOV4uJEo4pgUHt7YLqOA+
         C61PiLf1eFbDVctdP1h+jCamjwyj6sg9OKo0+ZlFqYpzK9DYcDQowqg7SacMUMaYgOP6
         iR5NcyeszOlVmC4ApNv1tJ8isRsNBwSTW2z5Z0bnZ+xiKtE9nqJSLKparH6+jDWThMGI
         m7CuUX0NhMx4XCayicTFZ+OZa5QIjpEEyeKpqMgNO8dpNOG+X4MRw+BGs4QQ7dLbITdI
         UAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbQbmJD7TaXQcZiCNATu6tngMjFLE2fFGGrH1fJb8I1M0z9eCs2SDYpuG7tCIE6JwSa8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmL3JTY9CxJlhIF8TKAaBwwc+QI8P0naC8Aw5N9u0f3JRlLDrs
	I57l3ExZJtbOrUuMePVucZAS67BiXFJcgHeGaENeOLVcu3tc2yKqaD9u48Ey451henkvnTNXfqE
	XRbI3QnApcz3LfW/zIk16oRl6U1pD+K0=
X-Gm-Gg: ATEYQzxi5hr5ezpXnKXfmqwO4m4PCdYhzAqqjbsYNS/ic782b3d59UQUBiIWcUHElvz
	yaE8bYtQkaKuAQK291KFSZOQkTW6pxDQ0aor+5FYlU3R2G/Vhl8yg8OvPt3lZaByQVAb85gU0pm
	zILYU/A92UDLjwrR2hzfHoeP2JUrjzBdqAWW9h2I3WYYV3aT9a0H+WcuXjXSqqvbnZDNTQXwB+s
	QRw+h6VVOpglOUZ5RnMdW9o5iryTURADVnvknlC6QoQhbc3isQIKJkP1fcsD7E1Gwk3ONvl0ELU
	WExidN9VBUP/rwjGAQ==
X-Received: by 2002:a05:690c:17:b0:797:a162:f7d8 with SMTP id
 00721157ae682-79a1bd1feb2mr19022287b3.27.1773370205576; Thu, 12 Mar 2026
 19:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310102145.857810-1-sun.jian.kdev@gmail.com>
 <20260310102145.857810-2-sun.jian.kdev@gmail.com> <9f1acc68-823d-4003-a177-face6cdcc950@linux.dev>
In-Reply-To: <9f1acc68-823d-4003-a177-face6cdcc950@linux.dev>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Fri, 13 Mar 2026 10:49:55 +0800
X-Gm-Features: AaiRm52VZvdjd9yeA2XiME1nGhh8eFDEMbwgZDYRre9CaRo2zzF8ziC4MIE7nL8
Message-ID: <CABFUUZHKVNB9F8ra3Ry6ymF7KKPP8u=zOEYEvZdqayVTYaZnJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/bpf: Skip bpffs debug iter checks when
 unavailable in test_bpffs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 5:44=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:

> In which situation these two files have issues? This already root

I observed this in a virtme-ng guest running as root, where accessing
maps.debug/progs.debug returned EPERM while the later pin/rename checks
still worked. root in the guest was not sufficient for accessing those debu=
g
 iterator files.

> access. If file operation failed, that must be due to your special
> situation.

Agreed, this looks environment-specific. I'll check it further.

Regards,
Sun Jian
