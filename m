Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF1381B02
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783924532; cv=none; b=rjby36KE7u114rF8LXGN8+xflSO+oUN5MD87dRD4VU+P+H9ikx95keAhzH8Uf7dbgCKokI3eduxURu5SfnXRDGkFclLiWvjKPXIzI+Q7ZsDnKXvDqeW/znlDt0C79VlnSMvVpSwxiGNptH/ANzBnplTv1VNtshH7edE2Iyf8ftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783924532; c=relaxed/simple;
	bh=BEORnXxM6ZYhnHtAqG/+pG3egOgrrwmAumn/RU0cg3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LCVyIdTjbBdQKylSin119WdDf5ixRrkiDZW38wWfOuFTjMrXU/UPtktGZMqOpenfNacxZNM81ujlzv+QQlPHv3+E71yGgp0Wm8/xZjr1kWD0+wPhoevU1pcn9/6xSdkH/ako40AsC+YkmZsMTaA2iqr7OdiLyE/xNLdEYLGxnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e6V3KcTt; arc=none smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e6V3KcTt"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c15f8dd6f18so181445066b.1
        for <bpf@vger.kernel.org>; Sun, 12 Jul 2026 23:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783924529; x=1784529329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h7vE7Szm3XNqCxlRDi2ZCo5mo4ITxmNYPLIe9N/Lh5s=;
        b=e6V3KcTtU1nidHXUy0FCya7HuXMYKPCqDSrA6ShZ5fHZe6NelMvR9aHnFV4Nh1hUC9
         HNIyOK6D+1Qf7JeQfL0FF1WoqhMo5sOEw7+kOgjsNyyrj2ziBVujWWBPK1UpgQ2sNQn5
         tGolzTOesew44igiCUX0Sd1SzXDKiCAZ3trRlUCV7YS+/pQMIzKNptJDzqDVvn4Fcngg
         vBj+vwEPzIyXm4ms+x98Ntw6iOaLQfB24t/isu0CUHd+YKcuSHelJX3Oqq8GTZxEGvxz
         WMKuIPW+TDNBSHQUvD2fcobuamztg0OcvTHN+jyjXwY7J2CxbIuqxPs3Fial7aeqsIjS
         3Y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783924529; x=1784529329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h7vE7Szm3XNqCxlRDi2ZCo5mo4ITxmNYPLIe9N/Lh5s=;
        b=dTKqNrxl+zvd9iO1xY3RsUh3ERQuA0njXKQJALi/aMbhJYZDzsAPJp8IFS58MmWsu6
         ZXk7BKEihVopTEti8KDBRm87jg2vKVNj+QW/Vs1yK0X/iUHOoIEeVeWGLrs+RTSZ2rAn
         NmEIZI2aWchlBUCte/aia8DxWpG0HxKwxkxMp+Mo10MbPNJ70Z2X+f1FtvmDjAH0ajtA
         wuklFZduyjiO25Jat7iVecm3pKNA/aWMSlwMZu9R0gYwAjqI5naRAFm/jb3KyBIxrRCz
         C/H99u8D571lO9YpslE12fpW1ThLqnbsLJ8d9Vv3Q1ML+UoCJ4xuzqL+hFheX2qQeSaF
         96nA==
X-Gm-Message-State: AOJu0YwuPzdxpxQo7I98LzzqDyW0Yirg/PUXXndI4HuggmV6Kxtl8cbE
	u2MHgQuEURxhH8EkHleHxrBgP2RNjBEFMHTXxqoF5b3h6pkPX9WJ6lwxUihU/zeI26aL/SmVPrm
	rj9GNkrEATvN/
X-Gm-Gg: AfdE7ckal6Og29DInAqojfVjxYyr9+0ziNiQHACMj/puOosqKZyx0NiGyMiDy+g6fWR
	cJtEEo6V5YjUw8QpdFo6hulvJoUpNiDKcDf+TXEnUJk4h7g4xS4ZiNU4DXmGHfMjQGkLKwYmYDt
	59TbNWNcH3dvE36EicfE+r42Wi8KRzK8EMfcYiBgDyKvpCsdM/dXTmHd+7xBZota3/y9pzmHgLA
	2Sg1JHST7eCaxaR9uQxOBBzIkCfWQHRXZeUvdulJSOj5H19MwXtmAGHV1E0Ms6+R8ls/vDKHcZT
	KBm4MqUcTjykriHOrZJ3TIDMnQd6MwT63Bh/4L60+Uo2AnRGBY18j+1QRqki/wJeLHQZPqGoGhc
	0NLF9Fv5e+pFpu+POZtkAC/ypXybxPhj6pDmxqEVdFkjnqm1Lnds71caDPwSQXPNyOBwrq1x9oa
	RZkhK9xCrGpL0MhXryXSbyNIO+m4o0OZpnL+EI
X-Received: by 2002:a17:907:e1d3:20b0:c15:c81c:d6fc with SMTP id a640c23a62f3a-c161e9416a9mr199248766b.9.1783924529478;
        Sun, 12 Jul 2026 23:35:29 -0700 (PDT)
Received: from localhost (27-51-9-144.adsl.fetnet.net. [27.51.9.144])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a42ae81f1esm5074320b6e.11.2026.07.12.23.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 23:35:27 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sun jian <sun.jian.kdev@gmail.com>,
	Matt Mullins <mmullins@mmlx.us>,
	stable@vger.kernel.org
Subject: [PATCH bpf 1/1] selftests/bpf: Enable BLK_DEV_NBD for raw_tp_writable_reject_nbd_invalid
Date: Mon, 13 Jul 2026 14:35:11 +0800
Message-ID: <20260713063513.215781-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The raw_tp_writable_reject_nbd_invalid test relies on availability of the
nbd_send_request tracepoint, which is only present if the selftest kernel is
built with CONFIG_BLK_DEV_NBD=y and the kernel built from current BPF selftests
config lacks.

Without it, the bpf_raw_tracepoint_open() call always returns with -2, leaving
raw_tp_writable_reject_nbd_invalid test always passing without exercising the
checks bpf_probe_register().

Cc: <stable@vger.kernel.org> # 5.2.0
Link: https://lore.kernel.org/bpf/alRtilWhKw4zzMkI@u94a
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Not sure if fixes tag is the right thing to use here, so use the cc
stable tag instead to get this config change propogated to other stable
branches to make stable BPF CI's job easier.
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index adb25146e88c..e1797bd87904 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -1,4 +1,5 @@
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_NBD=y
 CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
 CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=1
 CONFIG_BPF=y
-- 
2.54.0

