Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792818714;
	b=f+2mnn56Q359fE66KLvov4VK2Rw/sjWGFJqxu5oixCINmNXOll9brMa5wIdmy05+jDvJ
	 fUF0jl7QrLtMtXB3J312BZkCUL1yXVBVxVQd8pasHDFTvnmc4U4PZZaeovG7k5U5IThQV
	 kgOyyFBFFY9LYDaQUNw4HdtLm44FyJCYvpmKvIhU1EmHD3dBhQ8muvRz193TZpXYmdE8v
	 uk4JdxdpeFmIXT73iBS9r2sXJj9inXWbonRLEX1NpbOuACz1nKlsNv/6H4tiP/zYG86/l
	 kdCWm0hXCZZlhm2EsouNZ9Kbh6bp7UUsut7g5cvJSLDTc6Ycz1Q0CW1i84GOy/DOfaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792818714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=AoaK595SCB7hdO2eW9pqSL/fNMCEkPgC1DhGYOnonZo=;
	b=tukfH4yyYQg5pn7r8cEBG0KSh7ceRGorMgb/YH9fbQPYzf/P7SnWFLtsVuMvpR9tHdtc
	 T7jobcY3eMHuVYF9dQ6Gs1LZXYREnzlK8RWA/gZvaaUWB2bsuZ0QmP5WyMUJfEUKnb/bq
	 hd+TaVOfhaVEO6fZK5gFBurUO93qDWwTMzIaJP/5Mn7G7xxxJa7LdRFwN5MnvP9BpabfO
	 kv4IPe4r+eeQEMkPewOEBgt4ZR0zLcY15krUQulK0t5wwLvgs8k3Qo9n3fyxMqUNe/53a
	 QFzfIkb7cRTWmEjSb8BFLep7SYC3eP70a2enhH2TujN4B6HVK8zM3nDubsgES9ZYWnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fY1eauR4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8B2606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 05:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C8B2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fY1eauR4
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e5378b281aso10332045ad.2
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 22:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792818713; cv=none;
        d=google.com; s=arc-20260327;
        b=ip8d+QNAE9F8PDHaf0sMI8sZao5YEIL5LawmNW2bWdXHjuXtZ7gg4gO34VN4Lyf3Zh
         iY516S4WjIZndCRt6C0Xw+khWHSCcHsKR1Vfrhx3LxLgUmYzH0zParJXPWwdi3mCNf+M
         pUjPpMZ2JpUG4cVArKMCnDjwLUZj2/eiPZJUuZQcM/o2iUOo61obI6UIUYaBMuhu7UOo
         sd7KnxLH58ae77NRornZqq0fjRkyrDneY1iWVCXFdO/1pdXeJA5bZjKksckpRlySIY2+
         1+t+4+lrOaOBdhNEd0W7PeX/G+T/3SWQY9mkBMjlyz7UNfVPuxAmSeczJDqz3maTkOTZ
         S/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AoaK595SCB7hdO2eW9pqSL/fNMCEkPgC1DhGYOnonZo=;
        fh=/TAeL4JeSlLbKSo/000IQl1RYX1VgB/U+Yhu1Kpl6KE=;
        b=CFfNfNAnH40DFiJk/5zt6+jNAfzhXvOxoW5YIxrVBZ3Kp0d0ZHHhNi0CX2oSc6Ic5L
         QNdK69h3v4wZKsHOiwI9u8GmV3wpY4KJ8GvbS2Ez6FHu6fdS+BJmCn2vpiOyNiOxlGF6
         23NmjpurnI74SkjG7JDztx1xF9w/femKtDqEfdqTrGoJPhct8/jij1pO8BxBn//z1gPM
         1nJbG4FxMKsrSMCM8ilGwP31Ij3wV+fvBzGOrF7Fg/DDGrOjfbERMEa/NgN05hmXnHBi
         HCiaWMQiFX59rjg8YAtUUzHC0E61FlWiroHxJkrvneIrNUvNPo8AFS7D9dZAXmRahXaC
         LnCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792818713; x=1793423513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AoaK595SCB7hdO2eW9pqSL/fNMCEkPgC1DhGYOnonZo=;
        b=fY1eauR4skmB412EUCuNqJpMw+sSdBUbC8y5NHBmCIktNuVVPzX020PcCmK27t/mf5
         rYQPme19YMESJkDRsa2bMo4zz5h317gZM2MsM5oQ5RvF2Ca/wZ6noBogBNbyFlkTju6G
         XxQ3uGenS+kZZemly+0yGJQdgnlDHKIgi77FbjcppHbcpu2s98APG1kTvSYeCo+aWqtE
         SydIEF4s+YnBzRsr12jHMrBQxZ0D/dWLLALOFBHAlrt7YHNiDi7ZoUQEXcFzQn+Rthfg
         BHYCaxg67DBuk2vZ4Bhm+DvQZmuxpw244/4RDlXl+8DTZmXX7V62COr8cNDCJsdUUXTG
         ftzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792818713; x=1793423513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AoaK595SCB7hdO2eW9pqSL/fNMCEkPgC1DhGYOnonZo=;
        b=rmsPhqFEOEynjuV0Zmy21LVCQmSut14sICnxrYrWU0x5+jqHgTKapJ2voTDS2k3923
         fuZbDq92lrrvURj6WlQefSu1iOQmDxaNeyAIpAvULhFllFF+uxop+lOUTSXavKNHrBGg
         r8bYrwscTrTeLyT6h1Mza5YetPe7/KcboOGJFh9iu/Ah1JzirKa51nAL+e2Cw9gu/x0z
         lFSG5plFVjp8VoLj4/8PShM8sFwDRKnEVfmBlF6/rlH6+8Spn1YiVw8qkX7kWCvatVaL
         IebQ8nm0010zrbxxJ1WS6eaNdmPPPe5wX40oCfIHXzwBjoPsPcSc+TFC1tBpgqDks3zr
         BUuw==
X-Gm-Message-State: AFq9FYJPvlzzuZABl9sh+2pRr/bbDUJzqFcHdfCelVL4eUQdnOCHkSne
	v8w2MjDcqzHwz7klnkC28+UGpgbanzxebN7UBl9EHPH/0bV/R0glftTuIJGsryiCJRi6k6jYBQj
	BK+rE/kBLNMxL/gNG7wduHXLrUnH4ZKM=
X-Gm-Gg: AYBFou06wQjh9K+K47gNVIaLwdZIJHgMHxzsCmROQ83Zn5uoDyaLBMQGp+h3iT1e4iz
	4eIc4OZB1AWXh4Xs3QBOMAr6763Jn4R7FQXpVUclsIQ+OqOvMKhbokEDVGWbRa08UHbx8DvtBXR
	QdGo4RF9bVwGTSqdHYKoDMlM+TSsE0vO1ZU38a0s4ic/b87Df2fpZNJCuBXSdSvqmJkZGzuRQH7
	infU7pab9+U7c7HyGF5NitIHrbPJOwx7SRBCsOKl+moz59GqeFfmPIEPmFNKDGqzToPMZ6mYe6v
	ewnAf4V4Df3QZMviWiFTj5CxcFM5Q7cK2OTglOZdXg9qSJK2FoK0sfmHeI3LR1k+oo3PQAuVCJR
	n1SLro3m7jbUArgUFzxZEMge9sEZweppTfu9M8otWCKgSkdbb98g9dzkOmaVzuLVwQffmTWsnb5
	FrjTuwvq3GtY6ajCGXIoHmYTts0o0dZPV8F/w0UIEL2nX+CxpYKOI=
X-Received: by 2002:a17:902:f691:b0:2ea:9c9f:b24c with SMTP id
 d9443c01a7336-2ea9c9fb294mr9339295ad.23.1792818713314; Fri, 23 Oct 2026
 22:11:53 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
In-Reply-To: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Oct 2026 22:11:41 -0700
X-Gm-Features: AclHuK9ULnc2y67Om6intTypVr0qomIb5NHBEsJZnGZrpXOaLbiYVtlVvgKdTV0
Message-ID: <CAADnVQJdCq8nKqPE4z1AOHhvwYg4=Acg1QT5ZoDHQoFQh1Peww@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/11] bpf: fixes and follow-ups for 32-/64-bit
 scalar evolution
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 5:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Follow-ups:
> - bpf: (zext32 (zext32 X)) -> (zext32 X) SCEV simplification rule

Hit that as well. I'm going to send a patch for it asap.
