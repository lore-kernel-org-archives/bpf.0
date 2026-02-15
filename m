Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812593EBF07
	for <bpf@vger.kernel.org>; Sun, 15 Feb 2026 01:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771120297; cv=none; b=RrkEOgUmOpgYsL/bz2JevLfqynuBtXqVCb2c7UpCuD3lRHITS0/wJN7RFyG8J2N/GbNX+xriY6e0q9qiKJr2Vq7a+A2lOI8it1r4ODFbX6t4osFGdWWhmK5Q5sThCCFppoo8HETKjgbk02HIGzMACP0vJDk4+3SPCslUXK5LPBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771120297; c=relaxed/simple;
	bh=aynqYx/4vXrVtJrG7uZcJ7qt+wuroA58UNg1OJqu4hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xs2cCXXkCN223sXhrtd0Lh2k+ppzBk/GZHO01EVcsvbmKOXqmE5o+j3SuElQt4KoeBDCpaE5NgUQ77ZTktqRdS+nLi47G6x3FwZe2TO4UYJBLwk4oZspfODxzlUjBGwjPz4Qz6PinJAsGQlzc8z6u36Fz3zO2+Bbk5uVN37Lyl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VibTDzfh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VibTDzfh"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a90055b9e9so8596265ad.1
        for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 17:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771120296; x=1771725096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aynqYx/4vXrVtJrG7uZcJ7qt+wuroA58UNg1OJqu4hw=;
        b=VibTDzfhQWQxOqxAROVMOMR/rxnvxk1QvremwR/8LyNSSXhjBKYk/rV7uUhKxVit27
         rPzOmzFi6ZQbKxAGh2H71sE8ohFocAZBMwL9PDRaQCB/+CMAPrHzzqaGMTDcDBrjti+Y
         cdeX/aX4bmcMplYL6kCi1J60mp02IG+Hlrctlgsz04doV5f1oIWI03kRmxNy+nMQC1OW
         qiXhuHPjUGMm7Fz/KWERD/1R+2GHP1dI4Bboz1bb4Vy7+JsHjwMZgd4/mZS2L3U2bGD7
         MKrC9Ez4MpPLv/5UqydOQzmgeaJw4JUxs0B0ndLDy+HoNB/+3IkReazluaOGXCEwlaL+
         /ZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771120296; x=1771725096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aynqYx/4vXrVtJrG7uZcJ7qt+wuroA58UNg1OJqu4hw=;
        b=lQYhPIsSPkJvs09+ub4RZUcyxopl4l24y3Cum/5aOTiqeVzBh7vGy1R6fYh4PTBY1+
         rXd33R9ueZUg+HemYd2FylCUzh9n0mrsi9jk5bgN0rYvGGd/khaIeEhH55rDfQg8Xe7t
         uVLNnsN5ypiWhZ6DGodTSUj5ttcYSXlxLdEkFrLi5P3VD5oh6vVdXT1e7dJwMVe4omT2
         CLp3vejy8I6VLC+E4RNUMDlWkMLGs3QFLI/LmiqJ99GkvMGrLa+O7n6Rlx9Lg08qXVXi
         WYO4nCXh7Qz+WA7s5KOaazVviuzJROE7BFkpNNiSKN31PX/QGwtGwM+emNhmCsOhKQxt
         qwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG0MWLLMRG4W2laxoNuEi12WsZS+rGNwJtfnBGtDe2b64009OzA02CH7l0B3avgxQKo/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlkhKVJhz3HzajpfLfmQLp8J64JWrtK/1Xhj5cf5W0rChnzYm0
	zoEMSFdBs4HpKH8lPwFXIq3u/9e/woeXV8UvEBN7E0ZC+y9+LN/ldVwc/1NUFXhz
X-Gm-Gg: AZuq6aJopqQQV9HI/gSWJKfuzYnEGI0P7VF5OqyKg13J/0GS+FdaOXHczFvEd/f4pwH
	idBCuCtR2NAVCwcXygVutJgbIwzGO70khYjHn6TMboO3UlkrzopVrnQfL21OQIBcKy1+2T2syB8
	Zr6unb7iIwvRWKJIj8sPYCkUGsoTjZRU1F9pPRhN5naj5w+VqI86EpX/f9tFfvQZx8phBCt7Vg8
	L8vXb8ey407aib9tTCzN4d8rNxQ9OjK4msJPw7wwEgDEunyBdi4T8a5Gi7VVAooWBG3JYXylLiz
	x1gzIva505e+xzORl8pLCgkhOkOYHV/tUsMtR2TCQsjdLJT3xJTlOOsSKcz5n/vdwTiIG8Nv0vf
	femDZFsUU4Q2AMHZC6ZnQItZOR8sE7as33+Y+8+0aS4dULbvKR2PneW6M/LJm3NzQjgCTveMY8Y
	jZEm/IIKux/pLehdmZjCqCTo618WuYOhTB3tSmU2w4IVBnnQeJcfJ5i4Eoq3ksa5hTRbccFg16k
	4t/EY+t0vxr3cf5t5E=
X-Received: by 2002:a17:903:3d0e:b0:2aa:fc73:98ac with SMTP id d9443c01a7336-2ab5060a12cmr67069865ad.49.1771120295840;
        Sat, 14 Feb 2026 17:51:35 -0800 (PST)
Received: from localhost.localdomain ([49.207.200.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a6fa229sm29761405ad.18.2026.02.14.17.51.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Feb 2026 17:51:35 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: alexei.starovoitov@gmail.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: expose original requested max_entries in bpf_map_info
Date: Sun, 15 Feb 2026 07:21:29 +0530
Message-Id: <20260215015129.75566-1-anandkrshawheritage@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260214115431.55574-1-anandkrshawheritage@gmail.com>
References: <20260214115431.55574-1-anandkrshawheritage@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Feb 15, 2026 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> Clearly a user space issue.
> The kernel side never promised to keep max_entries constant.

Thank you for the review, Alexei.

I agree that callers who create maps can track their own values.
However, BPF maps can be pinned to bpffs and opened by a different
process that didn't create them. In that case, the consumer has no
way to distinguish a kernel-adjusted max_entries from the original
request. The kernel is the only entity that knows the adjustment
happened.

That said, I understand this may not be a strong enough use case
to justify a permanent UAPI addition. Happy to drop the patch if
that's the consensus.

Thanks,
Anand
