Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B53472777
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245399; cv=none; b=ibZv1Xb5/VlXgi6V6TiAL1ZMMGDgB49L79Ne/wCqD+wRnn55Zd+ehB7p42/W2bCbWvzyglTP9dIoicfl5Cs2nq4dwPY9hOW6LY5tvLnA8J5sildd3SDQ95Cij7oKqz8FZQg7BCnHw5OW1aXS6fXJ0mD2IyAw3zn8O6PbamMWr7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245399; c=relaxed/simple;
	bh=E/m0YZzMmI4sKKxrYCkNhWsECzFNLMH+vihe3C9U+XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2ADfrTxjvcYHdOT9Qpt0Gge03NP9t+4LnLBSXrAEa9yq2TyKduiy+ZxU4ozjkE2XNeXVdgsmwUX7PoH+sPKcsInHiQUG7ayxs2ytRw6cf4q9Tu+Ekx7RXLN6e6ksEhHSPlTh/zKgIDI+3ZLgLYSObd9WxUJKaixR0vqXRemPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9Vj3K6E; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9Vj3K6E"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1ceb47d53so422394a12.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790245397; x=1790850197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gl3fHPMWpRPJdFz90a3E85Yr2KY3z5RbROryxbkDx9g=;
        b=B9Vj3K6EvS5IBQCMrXZi8+0/Bc/8MAK+9Q2aGGAASQ2fxlWoJV1ZOVQiFGdQxvoAFn
         ZLNcR9P2QBMq32uB4MQiw0vZ1ILnVsnlmmNkWeuPxy7jRTlkEzbXBk5HJn3t+cJaOEk2
         kx5VbUJw8CJ/bpifTf7S3yHhWrrMfjIdLRhGYI7FJD3KenfnNaUWKHr+3df1NqH1+Gwk
         rvMk6+yzdBubY+DHI1lfQWvSEUSiUu8Y4zh5Da+xlmEe4EEx9DfzfntKsC/4si5ZcSC5
         avLDCVzmuTMDXPaf7JchGBsHqa74PV3dJ6ldQlzzWxUJWRNQU6kq8a03nmXzOoxOQyYw
         rgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790245397; x=1790850197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gl3fHPMWpRPJdFz90a3E85Yr2KY3z5RbROryxbkDx9g=;
        b=otK16h8uubJiC2ahk/LZej39Odt+Apdp7M6UJjbPtJwd+51PWL8Qpxo49zuuwy81Xg
         t3S9tdUc0nrKNu1ioY8sy533TCZsUMYBi/huETgUkt1lo5hkOEV4WxQtXMCUQnP3wON6
         i8KFacV4lyTOu2btOSF1nyVtgJ9jyR0QNqNhxNn4OURYhAQ2Jp6OaeV+yOhEu8pkpQOQ
         s4xOiQb5Bx2nl/FVrvlwYUK52+hlELWOB/FcZ0ZEzmwE3lGtCYP4bIwSGAjGPCA3fLiX
         aOAFVwri9XnC5+UKHKT9C5J+fzl6tOFzpUilhGw32I4DEqLb9JgKwuMs4N2TCU5RZLZr
         w8Hw==
X-Forwarded-Encrypted: i=1; AKwUvBytXzrw/8SUFDwyMuB68+W+dGj/18c4QmpOZJD2hmHIMhcOKm0BoUBVe2bAPDxP3PgrBT8=@vger.kernel.org
X-Gm-Message-State: AFuF++lSjGtk/ZgbpaoFgWi6z99q5CA5CvtzTfm5S+XUx9ptOjr5Laz6
	DjEVx2vMhM7pKlSpUkp5t7vYtS5ah55JOhnks6YrVDcMWX51fiQdsoM=
X-Gm-Gg: AYBFou2OpqmWb2OWKb4JhGnVW2ezkit+i8jJrJmIxkHR6wJHaKzTmch5ZmRdn/Z2Q0d
	UAf289EvBzibmERYbcoQQcYwhPU3tjjfHWovGKlIQfRkhDpNxgevELua5iOV6yiIuLnew+LlC67
	r18fVdsU1BNiQLbtCzF3lr4mMLluTB6DcVLldd5WdcEeVinxHF6xSoisHg52UktF747LAeLTN5l
	TEGu5CGRKxT5ZM8c16PvL/NcYsnCkpVBBTH3w3KSnGKuNfAsjzrXGdan88Hm/MkFRpqHK20nEdO
	8tgmGvzka9pA/Jug/7yZwF0EwcBLoNADUvcJyT9YespJ+9Hbf9u9n8ya0ZxfWuFOQJDHx/Qwj93
	tgrEieSvHecdgKUbHcIE8W5G73/NZO9DVh6R0gTLevDwaqS9wQCvf5ueSuC57IPO502Pf5ODiA+
	Dn0SEgMjP9Et2mvKPUd9gRnOpQtNSEuJpYTwMwPe6f46CFmwkdGkfJ5HqW+g7VnfTua0pV2bCWl
	nUYGyF7c7nVx4eJeIXT2X0S
X-Received: by 2002:a05:6300:68d1:20b0:3dd:a008:575d with SMTP id adf61e73a8af0-3de0e89e4fbmr833583637.27.1790245396933;
        Thu, 24 Sep 2026 03:23:16 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5c1ab4sm2664431b3a.27.2026.09.24.03.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:23:16 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: bot+bpf-ci@kernel.org,
	bpf@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	leon.hwang@linux.dev,
	martin.lau@kernel.org,
	mason@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test per-cpu initialization of a BPF_F_CPU created element
Date: Thu, 24 Sep 2026 19:23:10 +0900
Message-ID: <20260924102310.2120408-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3d31f180b472adb3b215571fa73ba38641cc93a33ea2e8e82413f37957c2d99a@mail.kernel.org>
References: <20260923000801.1764758-1-donggeunyoo.kernel@gmail.com> <20260923000801.1764758-3-donggeunyoo.kernel@gmail.com> <3d31f180b472adb3b215571fa73ba38641cc93a33ea2e8e82413f37957c2d99a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 23 Sep 2026 00:56:18 +0000 (UTC), bot+bpf-ci@kernel.org wrote:
> Can this test give false negatives on the BPF_F_NO_PREALLOC variant?
[...]
> Should this arm either pin the thread with sched_setaffinity() around the
> delete/create pair, or loop over all CPUs to make the result deterministic?

Confirmed, it gives false negatives.  Fixed in v3 by pinning the thread
to one cpu.

Thanks,
Donggeun
