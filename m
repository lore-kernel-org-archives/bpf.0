Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB9C314A98
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525648; cv=pass; b=rfszrZgvBJYKQzHO4gUary0HRxharSHO1Ofe83zphZXkmum6qOmSVlCebIz69290coN88PAQrsNbl9/nZpI+Py2fOXnThA0wTMh0hiSjYPkshXikieWTM9NSwqSZNqK7aJ91ZqDUT3n8R9qrtQ+8VF5/mhtmIcfA2dsw3sXk6Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525648; c=relaxed/simple;
	bh=+OC/aOVSLfYfpueSMiZtB05tveFOE9PwUOUI1E84v54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsck+5W5z7oXar+lX+b1fuIEdZEECfbrb5ESUgZHmrIl3RuPppYwTIoer6bhNFmDFj9c/3QQiyikhEgXaXSFPUFa1ZjbqdaqB7XIp+0QSt8FhH4T7HZFsiPDnhukm03ahpmbR0JNleMcGXvCmJ7dxapS0rqmXllp883lHVhUxMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iX5T41zx; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX5T41zx"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so4654085f8f.0
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 01:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779525646; cv=none;
        d=google.com; s=arc-20240605;
        b=iILZsookzy9cJGCq71i8hFi+CvgAwK7M4gdzt7bWYBmu/1kKNHkU2M5J8SA69i3v6X
         m8QETvQhQZwWhfFTwx1xMSMNEXdnY71tmSSXrmCSbJ/MKBzjfhLq+ajz0uycdLUNyL9i
         yPnaBukQioIfZbQsUG0RDSBq9UvpbdYmoJUacHofjnJLw2I3Sy4o1eUtWjaXeggPXhqB
         1NT8K2Hg3rQRy0Zstbai0pGXx4xoXHNNmIo4umdrW3ki8tOOQ21Grwg2V3q4Q/k/qFmO
         l98DILkwFluL6Gs7++hWURZ7U11wvJfu/VB5VmbuYwULkhaSyrVbFbDI7ZxUENPrfPM1
         k8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+OC/aOVSLfYfpueSMiZtB05tveFOE9PwUOUI1E84v54=;
        fh=k06E3vP2FM7ubtFpMgIWiY65Hk2SCi8CImpmFT3YR0c=;
        b=ddCLahwxAQmwdFXmR3jGsuBSTiDFKu4BoAPaH7P3TYtiKGd0hnDEHu0QY07d6XXtrp
         5y94HPnqWszR48XPAF65aD3noyEsuJ5f/SE3iDEO4hOkaRhiQffOHNW/mg+JnNpnk9Qj
         Z5A4Rlv5j4OZnRsM4tY25Od/FROz1a8CZSSDX1Oxrp7fsJ/TNhJlfZ14bclsr/T+zntu
         +H+IxaS7EB8k31wc92SzjyzxAIUGNxa4VXWHOnGvvjtkOrODXGmUQCaeBPlWV7fpPo8K
         0MndjGkCt39xFpDrHibKN5N5dy0+llLFI/nSU0f81nhmbs/tVszQsDRh5VifRq8qeKBM
         E3hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779525646; x=1780130446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OC/aOVSLfYfpueSMiZtB05tveFOE9PwUOUI1E84v54=;
        b=iX5T41zxD9fuAykofZGOW/O5jpmj9Y2yiJa9GmubSCqOE2tkQFrNafvstH6zR1HVjY
         Z7gX49xSskaElWouNewMj+YvD7sqsNHhX5sdBcSqYd+8el5mo/LFJYmWL2S26me1cBaF
         tgNNwGe8FJlt0TW477pr+7cpniW5vMYafPVH+TFnJZ0/dXIignFXdfAiFKUQfzRczD+D
         66RgIUgnsK6SOqL8DwVGXr/LtVapJz0qWX7IGNhgcgNxfaZfv1bdGyNdHoAbomUbayQ5
         CQIT06phdclys79C+j3G/GjSwmk+Zp3EXnxaoXohcu85qyDV7ha7Xn2g1rNR7mAaW9FV
         P46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525646; x=1780130446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+OC/aOVSLfYfpueSMiZtB05tveFOE9PwUOUI1E84v54=;
        b=rdAlu+Fk2xCOs282WHkCbda/NceC4CBkCmXrcUgVQGpS4MFBI89PnBMqOaj+CTYzY5
         i8t3+6Ci124nxTPBeaP+p85vy90FvWkPnOYK2ZlHj2GYtSteFt8r7h5WIkVIE6dGKSkL
         EBDaEVB1KHPGb63/TUi8C3hT6Oca5cy/SPpdqVd1R23YYF1ulygnjThXwYtG6pyv6nPF
         UY2aSSaeR95OSfYYlnz4lxLhACDgK3B71Pel0hkE1YtnPWYCDHoaFzoCsDvvYXbrqg9D
         27IoXOYsiiy0/FMG6TV7IS3+9lARGQWgB3ggWqMXIG7o4AqGxHc2YU4Y2vX1Tq9Zeapb
         2eqg==
X-Forwarded-Encrypted: i=1; AFNElJ/mOZmBYBzERXYbDI1FxOR2jqtq8XWA1LR4MYcZ2BObyQNuG5YmynL1FUmQF22R81W6JD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqCtDyL2nE2+8D53eTQky9+XPAqKULyfTJQfA1P27sdDH1nZ2i
	EY5Dg4NqdDzxoIro8zlCFsQGYX9uvUmsq3MlJFCAoKV6mOndfYfABC90eGSs8KBO2tJY8oKggYS
	kqEF/DQh+Nk+EJUuI5YDvHiFBehEExVU=
X-Gm-Gg: Acq92OGFq9sHyNQ7cUKEo1BKC6wYHU580rTt+6YqZjXDvESoAGjlefrCWaIujQOGyBl
	1AP8swlzkw5KVBsOKTYoTJDUoH5iAQ/LOQMgsNyFNt5ICwy5q8HabpmUPC/HhfXGtEt1x6sLntF
	0TE70UpQhLV2YRFGRxZgEklnME84bqEOFi7CO15QW5DEdiK7zrl9jWPUykzN4kx6wyTQgw15SJL
	dhY63ZsXiBMwNYr48q6DLCMGNndDN48rNBxlfZCRkm67CAV/MAfjQmQKIo6TexnUsMg7JJvXAxY
	n1y9hzgE6NyKiuW2/TpdATFkzL2czfMJtr71QEVuOmTiYdbYhfznmCqOgEkZewKC8tKsug==
X-Received: by 2002:a05:6000:480f:b0:43f:e43a:f4a6 with SMTP id
 ffacd0b85a97d-45eb3691f71mr10856462f8f.6.1779525645710; Sat, 23 May 2026
 01:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522023234.3778588-1-kpsingh@kernel.org> <CAHC9VhTk3qovnQQjK0C_FWU605j6Yi+-poMVVMS8WycRFg9xhQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTk3qovnQQjK0C_FWU605j6Yi+-poMVVMS8WycRFg9xhQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 May 2026 10:40:34 +0200
X-Gm-Features: AVHnY4LlOQmp4YX4PYqO36uOP6iPXDHyE9oy_nP2q8n3NepeatlO_xQBklFCrKI
Message-ID: <CAADnVQLbCz8nCLS2W=Hpk3hVSBqHGuGyVjeKYPnNDhhu_1UiPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] Signed BPF + IPE Policies
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 8:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Blaise has recorded Alexei's NACK on the Hornet patchset and addressed
> the TOCTOU that Alexei identified.

It wasn't addressed. You simply ignored my feedback.
sashiko spotted it too.
All other sashiko bugs were ignored as well.
You merged buggy insecure code.
