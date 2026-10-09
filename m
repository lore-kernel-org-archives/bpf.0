Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F74931E844
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791510547; cv=none; b=lU/b2hkj0MyQrow3meklr51wj2wAc3n1ucfKHElCnlYZJZGwRAqSUmdNq1woEjLYpAAVlStcddLBEf8QJOzoYqYAoj280oC/2pMwICXr7/6xmyfxGWAsUoQkzYqMBykCr4BUZ7MVNwLk23RcoA9LvflgwFHM2Y4ctzdMbpQXH+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791510547; c=relaxed/simple;
	bh=/O3F8/fnPaaAQbgA3N5cQ8juEmuD0KxzYBmWFz5OYwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XIoPWZUJgonBIPKLC6XaAOe+n5Ea937ZYKlVdgQTskrRu6+icMvmrYZZnbJ1LgAhOiLoAqW3qzlMD7ts9exGFO8FEF0WS+j6vW0RjSzutd0dN84UZ3JP4PaacSMu3szm5IHxuqH81P9l8VD+QVVScladanYuGo0Yrg0pd4YQvgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZuUNSjq; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZuUNSjq"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33c2520ad38so8699264eec.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 18:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791510545; x=1792115345; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LqGIztKDE2v+KNudFVnS9v8tY2sOexIdwSJPz5mBihw=;
        b=DZuUNSjqOcT9armKRGvVQpCLNRRhU22bsAgTMxosCKFHdAgtbQ0zYrlKQNmYF7nvWR
         /X8grCxfCeWOeMfBydOrBRkGWSmHwySva+hRZc5JBPiOBDFDPF0qCQKzZ0i6Ixr8YoNM
         /XvygBR1Mxyc5BSgYB3c9wPwnPM8+cGenAH3V4aQlAyX09fzTOIp8iOncI4pDVvBf/ox
         MZThFcRiAW+wpxImHbC1gDDB5cURNHsX7jdfLWGbOHJvz3hSwHCpTZDct5/lac21JsPV
         r8z4GE2H7mXKx+iIQtJfggkZDEeVs+JXIjd8CYcDGYaCKIRoJG+hsFqPrOqp9xHOd5D0
         nqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791510545; x=1792115345;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LqGIztKDE2v+KNudFVnS9v8tY2sOexIdwSJPz5mBihw=;
        b=nYyRYq3C7lc4Fy/dn2rw4PNSrCn55xoKhg6exBJld56G3B+YVu0SMmyIoHmk1OaERt
         zY3wwmRg9g9MjVb/v9quSQ3xY4TpxBQ7p0YVwUYngkn9Y1128eZ+uC4afZ5I5+8xmQT1
         RwrLJj/AvxF0EhsbXdC/wr0Gl/bK0ndlIp62XiBHBWyvMsCJcrWisq8x80qRVoq4yhKQ
         3bEDvAJS0PFhAnucbkv58TfnegXkpDu8n9q409W1mq9MWJrkxOqgsQMNV2CV0risZ6br
         y11XGR8JtWmVOPkApN6N/LueoKk6TrIpkdBAAI9yuybiVYzJsF5+whidrkkE1dF0nUwn
         /sWw==
X-Gm-Message-State: AFuF++lKPZb/aNKX5Z6ky63RGW1vLVec4WD1Z863JiOY1w4C/ho0BKKy
	NF8r8FE1LAFwMdnP/OjwU0hMoEh685o3ZY31RhiNp+7Yy32WbUeFBTRX
X-Gm-Gg: AYBFou1oDvUFn1zfTVeqScpGpBibi52Jt1llJUywuzjiHGEfvIIJCpOUfAPy6UnB3k5
	2kZxuJZ3FHe+lis8tnP/BkHFnCMp+wy4qfpz28rCwcc/c4pIHGdN88mfCynZ593hoCBHcZ3ZLmg
	6cST4rYIBAX0BHMv50wDLUFrFSH2EqwblTKob+uB7P9UrBcwTPYmhO7gRAqccirxTNyVckbaDOw
	GsyWzLsD+tEkEwhFSGXRRunAmMcAX6+bqIeoEHgyHc7VG/QecjZFlQYF+gwz0SXGhSSoxjmEfa3
	SvMpezQERGdaKRCf2HhMMlW+0UvrSEpyK9DWjnJbtF/ta+OSq7wstkJRFNzyEG1DZuZBMIFybx0
	OFDzg49bLrvask8B6BTPKyyqfuQSX7avpkknfDrF8PH9ueLTWvCfjOvCXxDQb7hLrfOls3AaOFS
	0ET1MIOMrWA+Hg31iEDt2YgD/cqpGL9/OUU/dYdvQ9mttgIAy29XK92+OLRjZZKMK5Aw==
X-Received: by 2002:a05:7300:f545:b0:351:1ff2:d013 with SMTP id 5a478bee46e88-3537e255922mr768524eec.37.1791510545116;
        Thu, 08 Oct 2026 18:49:05 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-353810403e9sm614699eec.2.2026.10.08.18.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 18:49:04 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 09 Oct 2026 09:49:00 +0800
Subject: [PATCH bpf-next] selftests/bpf: Expect at least one kprobe miss in
 missed/perf_kprobe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-selftests-bpf-missed-perf-kprobe-v1-1-c9d0f75f6f99@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAtIyGoC/x2NzQrCMBAGX6Xs2YUk2BZ9FfHQny+6qGnYDVIof
 fdGj3OYmY0MKjC6NhspvmKypAr+1ND0HNIDLHNlCi503rkLG96xwIrxmCN/xAwzZ2jkV9ZlBLv
 23PsYBkx9RzWTFVHW/+JGPydhLXTf9wPk6iohfAAAAA==
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Hou Tao <houtao1@huawei.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

missed_kprobe attaches test1 to bpf_fentry_test1 and test2 to
bpf_kfunc_common_test, which test1 calls. test_missed_perf_kprobe()
expects the kprobe of test2 to miss exactly one run, the one test1
triggers, since kprobes don't nest.

bpf_kfunc_common_test is a kfunc of bpf_testmod that other tests call
as well. When one of them calls it from another kprobe while test2 is
attached, the kprobe of test2 counts an extra miss, and the test reads
2 instead of 1.

Expect at least one miss, as missed_kprobe_recursion does since
commit 08a7078feacf ("selftests/bpf: Improve missed_kprobe_recursion test robustness").

Fixes: 01e4ae474e39 ("selftests/bpf: Add test for missed counts of perf event link kprobe")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/missed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/missed.c b/tools/testing/selftests/bpf/prog_tests/missed.c
index ed8857ae914a6..dc91be982dd32 100644
--- a/tools/testing/selftests/bpf/prog_tests/missed.c
+++ b/tools/testing/selftests/bpf/prog_tests/missed.c
@@ -36,7 +36,7 @@ static void test_missed_perf_kprobe(void)
 
 	ASSERT_EQ(info.type, BPF_LINK_TYPE_PERF_EVENT, "info.type");
 	ASSERT_EQ(info.perf_event.type, BPF_PERF_EVENT_KPROBE, "info.perf_event.type");
-	ASSERT_EQ(info.perf_event.kprobe.missed, 1, "info.perf_event.kprobe.missed");
+	ASSERT_GE(info.perf_event.kprobe.missed, 1, "info.perf_event.kprobe.missed");
 
 cleanup:
 	missed_kprobe__destroy(skel);

---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20261009-selftests-bpf-missed-perf-kprobe-05471f2aec76

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

