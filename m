Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7236E46F;
	Wed, 15 Jul 2026 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078890; cv=none; b=Kh/m7iRxQiSLMN+Nr2qwvXqYUpiYUrkn75KSc4ddzKs0WO3++hn5H/w84NobE7mVRljJq4fGG62dabO0T/1UOnqKhSEQdGo8g9AQcnF0MQDp0PvA+XUx4tuFACZJtQYZdYmZY06DzzggsTS0q3Pxpvbad1+dLoZiPFbKqPN9QUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078890; c=relaxed/simple;
	bh=l/W3VrfEzxmcvF860703xpbSpw51WDzM8aNwVBsCJ+E=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=p1mg95vjopDL4fX6tJPqUKwEzT4W6owonCN+xBo7JwS0ChPkHQj5grkrPTCO8Y/MMl6IMqOXXrSXac7oS066rTFTsfNuwWRcW/QOCoSUwberFgr9RaukP7WKncH9MiNQZNQlRtXdWPzNGh7o79q+YNTn04GhFcPNIxZmho2lZ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=J6aUwmac; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="J6aUwmac"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784078883;
	bh=mofxQ76iT0f7vrAWvuU0vvymC/QiFgVLL2Xsg3K8wS0=;
	h=From:To:Cc:Subject:Date;
	b=J6aUwmacRo01J7vU4gorYbCg6p9jC1ysZ85eYdyIhx27qHFGRGEnQqNNz8rC8DY8e
	 xHGj5JrLAbIb/FxqgAdwEA/baeLkocZljVoiJg+Y/z/5oAeS6opr+jCL2mDI1HE9Q9
	 ZNSZZdcqjaxP0jmn+IkKQ9LvhYQHmi9tMRKrjXdw=
Received: from NUC10 ([39.156.73.14])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 6FB10817; Wed, 15 Jul 2026 09:27:59 +0800
X-QQ-mid: xmsmtpt1784078879t599wrfru
Message-ID: <tencent_D8EBEA683E628241AF105196D465930AE206@qq.com>
X-QQ-XMAILINFO: NFUWtso/NFXenpIgzyPqWx6VYURrSIdZjKBEaSZtg9T5Vt9bkjR/4sJcfPzq92
	 87UE6lsc52JHzzyNL6txeFJyAc8QlN1DWNSO4WtJHok9zFCLmbJjWjqJKxGQgEj8XJ4j9QDbn0jA
	 WJR1CIwpHmmKtffnEdrrZFgZvP31YE/begDAhnL8FaKSNScq0348/RBCXQSdCxqlWij7oXbFvEdg
	 J73FJW3v1uljnvLck9MynpY4Q2HX/MC73EnTE5PumaHEjieM+ytpRqJUi9hpcl4VXyj5p/J3E+PC
	 JsLD+L4KTZ+F10BrezRl9UGlK8LBaaSF/HtK6EI13Ey7jNDwlsCeBjgKMZUYhdKhokOxFJOX7w9D
	 wyuK4Z++DdmKDVflh6Ibgrpk9LPiTISEogOaPHLJllZ4W81msKLMdtCD1u4xh/FYbbGFgCK20KyP
	 DlqkpbCfGvsg8l4skxSdXem+Mw/WQtjqDzXIhI2HDMSeApknQ/3jCnCcNwqeszSU5ZOseY5x5y8v
	 oGA20CbgQ/WG5YsqYuiNb3e6uHxV5wc4RDc6Q660Z+l+nEmEzNXczB79PUGjgnEOK8TzWk3AXJJS
	 l/MHB14VsMHPQ+miQNMHvUvRMiWFJqPtZqS6O5zJ/2r4R7tkh8gOoiebVH0+nDt62/OXOofg4WXD
	 meY2YMWItdIRkShq9mqGgttH1zTVXdPtWR/g3N/qygc8sFdWjtRIzp02mEAF3TR9czRZqanFLYX3
	 ZxVflLbY7waaQ8CzePoRRwGnKi9ZIglriDWd0e/Gq0LP5S1A0dOGdMY3gKn/4aQthGxWDIgLN3Ya
	 5ABiGOcmNUEmnP7HfoLTDrDWNeFwGgL+K6SYQlJ3XiXYODDUmDeYxHtETio0klQ1xu3u92uB3Kpq
	 tvkME7mwv2Zf5cGA2ofURkUb4uuyInbMkbHKsQ9jwlGXOt3Run8YQPAOdNenI3uhw8WK5N9sCWW1
	 TdWNCzjCtI3+5KsZXcU35D1lkSmD+rsPFn9otxVx+sWzmZNE9d43Skf11KsagQVTlw+fcg//ycGF
	 yGJDRGOmit3xPyh9Y337U3OBdtlc1xr2sAz60Rd8UoiZE4WJyfelBY4uAV/WYkuMGx/OO5C74NU8
	 hkwqD3XYPe+OX1JX198Hflmue6DJTTpPTzd7WT/iz2KviZyGvLCVXRwLfWu8Gvff4508rp7Qtj3v
	 HEbKPcOh78nT67fXApn1Jud3w6
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Rong Tao <rtoax@foxmail.com>
To: andrii@kernel.org,
	vmalik@redhat.com,
	ast@kernel.org
Cc: rtoax@foxmail.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Rong Tao <rongtao@cestc.cn>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next v2 0/2] bpf: add bpf_strcat,bpf_strncat kfunc
Date: Wed, 15 Jul 2026 09:27:25 +0800
X-OQ-MSGID: <cover.1784078494.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add string concatenation kfuncs.

Rong Tao (2):
  bpf: add bpf_strcat,bpf_strncat kfunc
  selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs

 kernel/bpf/helpers.c                          | 92 +++++++++++++++++++
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  2 +
 .../bpf/progs/string_kfuncs_failure1.c        | 13 +++
 .../bpf/progs/string_kfuncs_failure2.c        |  2 +
 .../bpf/progs/string_kfuncs_success.c         |  3 +
 5 files changed, 112 insertions(+)

---
v2: This patchset (resolve some bot suggestion issues)
    bot: https://lore.kernel.org/lkml/cad393253d7633ca397ec2a235596e2b45a52b595945253fc0451ce0446840ad@mail.kernel.org/
v1: https://lore.kernel.org/lkml/tencent_59689407B1C3204B08362BEEF244A5FE5505@qq.com/
-- 
2.55.0

