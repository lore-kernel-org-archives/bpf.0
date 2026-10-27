Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118564;
	b=KawXCl2WrhaeEhToCSAxYLXHY2k3dnp1F6uGAVJUrmTAlcsT6drVOOFGi2ESIAchK0IM
	 mofrNLVbA0u84Cs4/uYQ39R2fbJUWQuwbJqwH8kjSaW0bP+CXz4gbV1Ey9njTMAUoQngD
	 ZLuMxG2l98dPYv65yBFri414Wra9lbcitj2P6VLfCKAp5QAsdUfoyZDKOHetHTFRXBgct
	 gVgLKRp9BSkNDNW7Z351DusjJven+zR1MwQAqM8RDd4SOfzaaS8MQbKpU2gDazj9wgk1B
	 sIFj91Xx+m1TVI2fbSrNhO1WzjSa0e5ON5Q9/Gy5SvlJxW1szfNcF2/J20pfxPuDZJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GQZGJeSpKyzleV5tnvZzt+FXSaWm72txTVpShChFQ+4=;
	b=zJd8INDrSzA6o4PzGl07WDQXD0uip9hh9Cr1iTJnz+KbrfJzhk/CXag4pygTyqs9fcCM
	 4Piri5w6Y70UYE2+iZrucw1p905XxYM6fHuE9aLNnDYiANOzDhxm+kvveK5bu5pgCkkPi
	 o2jI+5Y/1WlPyxMsB/zfGFaytIg99tjt856jFghuK/zQZo4Qj93QCpIJNDWuGMqy6VJ6E
	 iYKqqQBmrMUfPMuKhcz/4imx8ffoMt3q/gETp4GhB2QUWV8FxmtGbOFPEkUnmx4/N2rUz
	 RQ9Y/1K+wbtT1tcroBZuu7837vRSo7HbSj3CHYG3wtJ8zq3amE9LGEGW5zfbfZWfkkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=NyQbr7lk;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855CF606A32A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 855CF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=NyQbr7lk
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3acc96a256dso63567a91.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793118564; x=1793723364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GQZGJeSpKyzleV5tnvZzt+FXSaWm72txTVpShChFQ+4=;
        b=NyQbr7lkksXldNgOuzG6kzjDwPd1TwOWi1qEN8TKcR+1Z/1L41jyaZNidrd/f5Hj/K
         SKq/YX7xAgxFdE7VEVDzFVbb1VmxUkTALqjzDYeBEwH3/R2FoObTTpATSbqI71Az6YhU
         reuQM7oyJpe/0VlH7dYENr3M5sWN49cQV/lPiELXbtdvWqPMJH/1scrZHIX24NGTzLs1
         VuQZD+/9UQHQWJmLYePyL95wDTJKsWoYmhD4bquSob09CUeVqbIsqyHrcWNwdehmlrGf
         H/YPJHA2rUQvMbpKAdnf5J32rx9vjJOYWGPY2N/B8QeCf+TYe4n/nuJt3hwd7S4bLGtZ
         Pw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118564; x=1793723364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GQZGJeSpKyzleV5tnvZzt+FXSaWm72txTVpShChFQ+4=;
        b=yeiwiPICZE6O18Mf3kuLI6F28vA1Eu6asmP/cGFw909i7Jqf5K/JiKiGHnr+jw4MV6
         Z3izelq6qugMhooj+NyvkTXQDUnuPlif0k9XkEVsUHTbpKl3jwVeX0V0MOBsXZcWxVqG
         Gm/O7F/jJ+nTBo/X+Krlv5JHq9C8x92HSqdthL3dXBmKkTpqgHTp6r8pZwv8KADzxTYI
         ZzasBusL3WamU3OCRdQZxZkTWMlchegmSr8RPwxxASdjfB8XEWlAvWxvG5dj7kkJTffX
         YEh/vHNKoAt2BWO8cetzQG1OAe3zZD7GyglcJ6I4zhCA7bcD5KntJLXQbpSh1hq/yvYN
         LGDQ==
X-Gm-Message-State: AFq9FYJAk2cWmpDp6CEmP6gJRfaBm2nhBvraCLxezp0MSkWinzmVZkDf
	8RrQWljbeuu8c+3k80VZLAgU4nOwm8rtwjRRTndmakWn/9NL14BmK0OYUcqJEn5IcHDjEqYm3f+
	ldqKI
X-Gm-Gg: AYBFou2/JDQrRhDPiYLaw2PgHo3VlYKCcTOZ5ooZdRcRshEA7LdagIiWQJ2w47ZEhJF
	MZt5GD+7zxJHHqWvH0y87AAcLwdPg7+pA+GeUp4D0BVzo/VoyLiDs5pt9zOqK6AjG5jkWP093ES
	+qbCOLeES3lJI0i6MIpP99X7Ea2g3/ImBwbm/SNi+cYpjM2KNvHwucQo2mhzYOQR3gGSSpX13Zw
	7qyJJSfEmd4+J6o7IP4C8fKsY2hfdVbDS0AH8RUjmNLmJf4KGbCBc7rwG7dLGwnJjn3ojIBgR+0
	C/0uxprw4O4SOGZlQnHVU0E9uB0jB+3ZX9dM7udC6XLzbYU9MeGFzUmMSAfhGzUJsZe47fXRoNm
	ghMW7Vocowv9yRDsd96nsCWP+ab6e9SujNSm7lwSFztsKYDE4IEr6jlWlnqOv14D1PAvQAlgCQI
	gaaejMdtOo2aJNi/yMLGfKvz8enkiWqEn6g5zxTJdaD9rJsfBZJv26pJyTaxtTtnuOObNh0TXia
	aewQnljT+S0DEg2ck44S5pYbfTjLZW2DHkIKrB8yUhQkALsHMks1zzb+NWE7rn+5DF99UYcntko
	c8eXVdmDzgATkD/jnA==
X-Received: by 2002:a17:90b:4cd1:b0:3ac:7449:40b4 with SMTP id 98e67ed59e1d1-3adead4f730mr7774136a91.45.1793118563927;
        Tue, 27 Oct 2026 09:29:23 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb75254sm7288854a91.4.2026.10.27.09.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:29:23 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: libarena: Make zero variable type __u32 instead of u32
Date: Tue, 27 Oct 2026 16:29:16 +0000
Message-ID: <20261027162916.10996-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027162916.10996-1-emil@etsalapatis.com>
References: <20261027162916.10996-1-emil@etsalapatis.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the zero variable used for loop convergence to the user-visible
__u32 type to avoid missing type issues when including the skeleton
in userspace.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/libarena/include/libarena/common.h | 2 +-
 tools/testing/selftests/bpf/libarena/src/common.bpf.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/common.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
index a6220355a697..940e82cc2928 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/common.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
@@ -43,7 +43,7 @@ struct {
  * imprecise. To force the variable to be imprecise, initialize it with
  * the opaque volatile variable 0 instead of the constant 0.
  */
-volatile u32 zero __weak;
+volatile __u32 zero __weak;
 extern volatile u64 asan_violated;
 
 int arena_fls(__u64 word);
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index d859bd538c52..c3c5326d8ca2 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -7,7 +7,7 @@
 #include <libarena/buddy.h>
 
 struct buddy __arena buddy;
-volatile u32 zero = 0;
+volatile __u32 zero = 0;
 
 /*
  * Storage for the queue nodes declared by bpf_arena_spin_lock.h. Each program
-- 
2.52.0

