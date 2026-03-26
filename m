Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C5E421F0A
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546793; cv=none; b=WBY+MJ5nq+qGtNQ3Lz9jj47DHp6j11le6r0SvimMogloxVZgRvpXBWY3dqLsEYDjx//xunFkXrq2vstc5oTdOd7BlwXKwnRHhF7WWPuMd2GTPmJ0UjfVyHgY/DI5W3X/l64aBycKAlS5u+zLGR9vm0da+bGffQOOr03X57RX4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546793; c=relaxed/simple;
	bh=JCGzrWdIQdlpYx+oiyMwhQupD3Xu30zqNaTt9wFDfbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYnSpgCf+m1TopKpb5JLEr6K65bZTfRrUaeokKlPYRNSpHS3UeTMsiJ16NsGpVP8OJv38AEcgJMxVuqffAqEyRJhRtcAquTOPd/5WRvSqn79S1yf3ELb9qYrnb2UnuUOM0YO4Hb45Ju5/2mm62BNiKnWxNJuguhDxz8NgRzjazs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+SvhR06; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+SvhR06"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso778542eec.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 10:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774546790; x=1775151590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvtNp/oHFFxplLbJx/1Sgm8P8mLVK5ddnAusYKbmaKE=;
        b=U+SvhR06uYCBVcjTLH25aObjXVW+KsAmAh8+V2nVuDcZ2jMDL/DofXufYJ5dh+e8gk
         PtMyNgpf7S0t0DxVgPyjrn9aVOv0DUBqopxw512Wbi9bCccvSAD2+BfHzIHsCe4sJQtW
         YNywanSFrkEqLIc/QEaU9cJmcyXE4Eqf0eAfvZUS1TucRypP7L0j0pD1ONc42Ul8nLGP
         RIviCNms78L3/s6s/f8JxfEYaP5WslgHzYmYY8QKKWmbbBS+IS6//kgFzJnpe51ijMYe
         xpbv6Jbk/SCguItGJzlX8JQ6pC90/KlwnTAjDbSR7XKpjgk6HVJVyxgOdkS+dO3B+uTQ
         wnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774546790; x=1775151590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JvtNp/oHFFxplLbJx/1Sgm8P8mLVK5ddnAusYKbmaKE=;
        b=c/jIZqloAEKOblScvd0kQAj/Fxd+GS+zxR3HISODMC+nFX3IEF8ArkS2Ogz/6qgNSS
         K+id4BOohWsyrhhyV2AdTcwdwfEU/12Vw0dMacuwfzxak8uOiJRP35HLHqIcIw8KmGNU
         /4WeqDFC1lDQh6gkHLFXd6vRGRNlprPm+30qVA0wZwGBusaCl0+8wZhfH/7uD2RIA/gz
         qMdsdW+OKGSB2OocrtvGZ/72LydpVUxFw4n6x+Fd9/6+dNuM8PSWt2mhV/GAR+yvXe5u
         ntMUPcswz8PQINeuPwkpYgDkC3FU0TOEwEtkk8fzJF9Le+mK/19SLeJGctynFUsJJ3fT
         MuHQ==
X-Gm-Message-State: AOJu0YxG+MWTZ6YbQLTq2aKP08M1ydpoiaabqRJrmAhUTtTrTiQcR1Db
	ogJQKnELUKn6ILCOp9Sq8WG6IlO4i5OjXYJZzeRT9OeBcl4V8+SqHKuc8lHknm4h
X-Gm-Gg: ATEYQzwGbu+21zroFvy353C65xBK14I/+xJADl5WEREqW1stbCYG+Iv1fEQRbTVCKr+
	r0kFk72elFa7HoVkNEtr/RuoFy+X6fbDP+7IczFDHS/HMcfq6kNXXzlV5Ga2Gg+APQwwMY+NIE4
	rlBj0sD6ds4IcV6A36xo2lKz2eT1ZpiLz9KvxTQsvpoSCVDFemI98JDM4g2qBvs0ktOm60G3bQY
	l/edtgNxJqWcNzWrw+ANF6XtY1laZQ5wmEkuYC/rPIzXkb9unyDMXJgaxaDhCEzfFtOSVe4xeI4
	CwuRVR1BGJCUsDua1OUdFb2m6W7jGfLfiL/oVP2othviRgjqAv9DlvzCA9PhSJry3Yy8u6SoqVi
	b7BTZhMN6OcWvYnk9pSfSpA4kgLn3HY5rSaUO2L7qPEFA11q5tW/6os9QM/4Cc3GEfrfr+GbY5z
	MpTW/4xSrB5OgCa/S0WcMPUXCWEfbel2d6UWPeuSoXbS8HocfUSO+bz5DkghJxDS9+BcEnMzmvl
	LPX0i4=
X-Received: by 2002:a05:7300:1491:b0:2be:1a8e:10bb with SMTP id 5a478bee46e88-2c1771dae01mr1303161eec.12.1774546790167;
        Thu, 26 Mar 2026 10:39:50 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::1:634a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec47293sm3075711eec.9.2026.03.26.10.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:39:49 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	cupertino.miranda@oracle.com
Subject: [PATCH 1/4] selftests/bpf: fix __jited_unpriv tag name
Date: Thu, 26 Mar 2026 10:39:33 -0700
Message-ID: <20260326-selftests-global-tags-ordering-v1-1-5dd2ced5d9ad@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
References: <20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

__jited_unpriv was using "test_jited=" as its tag name, same as the
priv variant __jited. Fix by using "test_jited_unpriv=".

Fixes: 7d743e4c759c ("selftests/bpf: __jited test tag to check disassembly after jit")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 0904fe14ad1d45aba2f2c8a9a12881a0d248685e..52cf9f3cccd0ccd8034b9786d787e53992a4a6d8 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -140,7 +140,7 @@
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __not_msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_not_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __xlated_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=" XSTR(__COUNTER__) "=" msg)))
-#define __jited_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_jited=" XSTR(__COUNTER__) "=" msg)))
+#define __jited_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_jited_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))

-- 
2.53.0
