Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9742B72621
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275233; cv=none; b=Ac8r9XK6qtOro5FFu1jnZv9DKZd046h6MTdLfC2xjam93f9kFDUT0pXTalsO7RjNKInAB+Be4HMWdd2LZyhJV2gCgpdL6o0U5Z940dvDwQor8O/ko+L0HnMTuunfr6TTW0tFwsEZaFY3nphNtt3K+8P7YH7C3YkCtb3ipUpMijY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275233; c=relaxed/simple;
	bh=0kU6F+Ep+BE2q+0PcOAxFkcVqKURdV/zzGEyeutO3P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODsRUAuYFuHZ0d0BikDaZPQl1ozzJWTFouoWF5sKjhtVWdIpQVfEty3eocP+YGd4Lc7wV0eZWn+vezg59nrF9zY+NOC7VPQYVT/W7sQwCYbfs06E8Z4yXWGlVSD53yzvoDmYLOjgC5YPbWhtHypp+YTg97CAR00nHI18Bm0oQ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSKsZM05; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSKsZM05"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c85825bbc4fso1073883a12.2
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 17:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780275232; x=1780880032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kU6F+Ep+BE2q+0PcOAxFkcVqKURdV/zzGEyeutO3P0=;
        b=DSKsZM05F4ewEd6A87rQF7BfVXp/1FxE0dpwI4DTdbyC1HoAAZfjgdz+shSTnWmcLr
         zVVVpm7GyVKC4pIk/MBrXJL7xoEJKV2zOSsqIWoVfJ9Y13CbDFaH1ZU8qEacQAnXW2Yb
         84iOdrj2TC5AAzGbB3RqZG5rzN/tn/vzu62doNbxWmTk9e931Vj/ydPHOk87D+w3+fUw
         xHEC6JwxM0oykuWtR0CiOeQhTKx4/s+jecjEdSKuFGYwCxmdY+kXg6ly1IFOTtHF+HmE
         EoWL+QDq97bcnDy5eMzsxRTMw502h3ao5E2zuH7CYkv9HG/MQOCj1xf4yBehfQMhAU8c
         cxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780275232; x=1780880032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0kU6F+Ep+BE2q+0PcOAxFkcVqKURdV/zzGEyeutO3P0=;
        b=iixKINNadEAMWqX4idSBDlYnZ+ihooNEdQyqwa7jRyta++exWA2a7N6j6/WkgHs42b
         gKYCJe8oInUXIZFi3OFpgQn3PW0pyQ2IGHmTMrLzZiU6pCUxmO2lXJRaw/geW7OoVGP/
         IsnDBpIsmwTwrhRMIUnlnAzKlbbt6zqY0FK9Yly0cPq40xKxgE9SNDMdt7N83IYvbyOH
         yopraZ/bA0UEhJK44YQs6yaZl68IDbDPLtbvuRXRLZJQJlaFWuCrasMGligE8ZSKAEbp
         cnB7ooCgjIx5hkhaQaAFzjya/wxiBSK5xPJIH+qnHWVFZv5VIpfn6VIuybHz4tW5tjU6
         BwLA==
X-Forwarded-Encrypted: i=1; AFNElJ8o31U6bDeYVf4Q50YnwOy5tsVrXGACXAmqSPFrBEUs84pZj3pQjuoQaVC8MhbfphZWZmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3kbLVGG0t0jMFjDLC7BmVyYLtTblur4jL53wrOVzmzkeqCeBu
	fB3U5y5RsXFCUfO7B8Ny7QPHEIsuGGwtANZbRx6WTKu0MYW03r+Ek7jK
X-Gm-Gg: Acq92OECpK9u8rXVVOJsfMGVDZHIZMOAFOgAyGVjbpzAxAxDDwOP+QnN3Qu6XtZ5U9E
	Z00Z2lMWW3MVmZLI9m/4b17tDU+65TA9VoLGhu0q6CQqlntvP53YIcNZ83vdQRGfXVv8SVo7owG
	pSuRKhzUHv/cCqz19i+dJD2xFSLdklLXOVqQM4Or52cqYWmEg5SwglO3ypNfm6sL+AD+G8QVZYx
	51iawo4mcFLqfGZf4gpyvZGHkdq+l+FD6xhExWrZWqdWKX/QkrpwDYqa89fc2XmqNq51Y2UfP8b
	Cq1MCjqV+ax70QuF37AHu0HeJRmPwCyd7ldBFL2+rp5K9xy1DCgM1j2bVXVIPdtIG+2EFhFVDtF
	1m3/Bt6w6Rr6rp/WA6zzL5XXJpLMRtNiDXxNWFf09y8ca+qnIpvxfY8IrxivEe8TE2CXrb+UtQF
	LKZh/ojxlUytBSZn961QVH7HFzya3P2f/HEOwll/E=
X-Received: by 2002:a05:6a21:498:b0:3a3:4604:9585 with SMTP id adf61e73a8af0-3b427fe297emr9798594637.19.1780275231820;
        Sun, 31 May 2026 17:53:51 -0700 (PDT)
Received: from laptop ([175.204.13.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772d5ebasm7581295a12.27.2026.05.31.17.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 17:53:51 -0700 (PDT)
From: random6 <random6.xyz@gmail.com>
To: alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	puranjay@kernel.org,
	random6.xyz@gmail.com,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] selftests/bpf: Add arena invalid node id test
Date: Mon,  1 Jun 2026 09:53:46 +0900
Message-ID: <20260601005346.26716-1-random6.xyz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAADnVQ+1QNO3rGJi4LbbURXw1HfxXh-Z_d6bejvKFHauQa2COw@mail.gmail.com>
References: <CAADnVQ+1QNO3rGJi4LbbURXw1HfxXh-Z_d6bejvKFHauQa2COw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Agreed, the extra coverage here is probably not worth the additional CI
cost for such a small fix.

I'll drop this patch.

Thanks for the review.
