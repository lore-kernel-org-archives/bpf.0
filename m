Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2177F3EFD1A
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775159273; cv=none; b=JhI4KT2SBHNpvufukeDAneGZzNRdEDjt6HxgBcxTwMHyP+zjohhZKetDIvA5nA6opI+2dUe+S7ymaeXJ/YPRiRSaYH5R+kORA++flZUhluDBQkxea34XwswWkqX2xQt9hpNzu95vFUP1IUJrbE6Vg9dFQt+Ng3SsZUcAeG5MzfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775159273; c=relaxed/simple;
	bh=BOjE9saR6Ei+PFYOZOidv0J+CjSLLNSYRcEFqAPPKik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tqR8hdyQl5moFInV2IXkVXLhixLxnmynY26AdOz5YjgH+CMoqlLqMKWNHRJp0SaZoumTFoZxFAjAYZY/JWa/VYVBQ0MpKOFHzodsAY4K6kTDLb0tW3C+US9bOBgEjjFYhUc4GCRPdGQHHvciZglJLMj2oSHlH6ie/9UwZIPpnxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yt1RmGva; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yt1RmGva"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82cd9d0eceaso966184b3a.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 12:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775159271; x=1775764071; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BOjE9saR6Ei+PFYOZOidv0J+CjSLLNSYRcEFqAPPKik=;
        b=Yt1RmGvapVFuPeUgORkIsu2f6z10OIWqUNAVaty/K+XCQ1b9TZ4ihiAYHqy+EtDMtN
         HvTw6xOV9yIOymVIz5KlPK94OICK79bglcC4Qa3Qk+E8xk6XQEKQtVJ2es7xw3mSah21
         dx4vfpqSgtKBI/w1Br8T7UlPsR0Z0cht5W0+9+FIaumEOnmrhRSf3Qy7+5WyG3r0D5C9
         UNwFjPTaooMTt8Huh19uxKIRHhPZMVEiYNCaLIILlPqIrRyNVHZcmM5J1sTVdlxK5DAf
         eg+pjYPecmpbuGpKsxnrwsojx1tnmpa0ZdSC9jU+m+H1llXYUKkHrnFVpV1znZDZCRv4
         hGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775159271; x=1775764071;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOjE9saR6Ei+PFYOZOidv0J+CjSLLNSYRcEFqAPPKik=;
        b=i8JNioCT3lJKc6Eo0D2lLHaTu0Qhle05cnztUfkrLrZtcFyhvqYSMSnkzHs4ZjLEJK
         YzYSTEnryRL8LI/An8XorowqcO33I/GOoR3wXDQ7Yc6yYKZPkh325yWgXKOLIqFEJhE4
         1TdKrhte24HK+OYzv1riGeuvJJXzq0Z+I8R0FiQgDAnaC0kKk+szKisr06sVgO6xmJvi
         lGraj0TugZ952I7CgpSgS2QifLN2QMq0OGZgDFtqAgxVvx/f55bYmAlrNxNpQc8/InQ0
         XFZ7EUupsT1IIalygkYYCrD6o9nKY4ryIYvQ/3ZMOQ60FlvFrrdgz4Wa1YK4V7mb/hOa
         KywA==
X-Forwarded-Encrypted: i=1; AJvYcCXJs2RTI60TfMNU+jMVrhE8QAE0C9Mvndmhvt76RXdaI8d+ig3mh4Vwn0E6kdrOx4z/aUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu04KLdf81VOa8cD7MJXDNKTFx3uzqRBEo+UbjCzetnIWJyUZG
	gFVMk3ndQea2Zr91Y9gbD3lPam+wq3rzvu2HHm47dTu8DyIVRMXUTc3p
X-Gm-Gg: ATEYQzx6j1M+jtPcu2e+0S8LhFzVTk2rkG5lsxhmD3hAt+WT/8Y2BObLvYnQtQ89kcf
	GelN/1WdMmL3ac5Tb2VXtYWQsBJV9X55kid+l4KmZ4YEGh0gfCtyaxcuNBgxs2ZSST9tXswBl7D
	Ktc/qy/rKCyJhSrrZmTST7MUu2eimxHrFcVV1eVITbwEB8hs1ox0jcYNcyhUGydti+u+lmYy0eU
	bcPKdIR9H0AIn+kVnGfLlFU9H9uIly15IYITVB1rC37Y2EMxe74mu54NmJlq4Ikz6QAmWjQBJWk
	paRGS2SpFTasyAh2ltNx1GNvrsG6jAUw1bN10stgdfHTm3W4oK9yjy04PGfsWf0MvN4/nOfuG9r
	Ktp/knjwK4o4kZFOlrQVfzNx3L14WQQMOJ6ccUGEUq4j7EuZh7rUsFUdOSp2ZBJHRSlDJ41lnU/
	UUFxJPIYgNXr1fZg4tsjAxV6hdlPY4uv7N6rywYzMCCUOE2M1Fhpk16b6gzgaFT+M=
X-Received: by 2002:a05:6a00:2d15:b0:82a:65fa:cecf with SMTP id d2e1a72fcca58-82d0da41a52mr399492b3a.4.1775159271371;
        Thu, 02 Apr 2026 12:47:51 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3dcbesm3839108b3a.22.2026.04.02.12.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 12:47:51 -0700 (PDT)
Message-ID: <0382db5991eea58afee74d8105182b74e3c1c63c.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/6] selftests/bpf: Add tests for subprog
 topological ordering
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com
Date: Thu, 02 Apr 2026 12:47:48 -0700
In-Reply-To: <20260402061744.10885-4-alexei.starovoitov@gmail.com>
References: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
	 <20260402061744.10885-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-01 at 23:17 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Add few tests for topo sort:
> - linear chain: main -> A -> B
> - diamond: main -> A, main -> B, A -> C, B -> C
> - mixed global/static: main -> global -> static leaf
> - shared callee: main -> leaf, main -> global -> leaf
> - duplicate calls: main calls same subprog twice
> - no calls: single subprog
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
