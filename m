Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129163A872B
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351758; cv=none; b=ooDaYVJR1pyS+F2S8+fpR05aeqF0FQn037qac4tDe6Cm6+W5mJtA07LpCxEeVErLyQqOsAJh/V+Hetn4Q3EJBBGZzYZz8WboMmpXnyfzCzHLMcYROlGiyPUpD0Vs7PhWbcjTieaKrfa4B+LJaVQ0vQ4rV16YM6wS1D6DqnG14n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351758; c=relaxed/simple;
	bh=x5HuJc8ryRcujdAvfssRfuCUtU/zCfH7JZqYpQDH/Ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OBPDer0GrdpQCVimTZsBrk0Z+1z51jiIxO8qNAJt7f+ld1FQn/PAQl3fGO6UI2oL64zqTfoFfMxTl2sK7ICn4cC48s+vGTKWL5lanXCWF2NYureOZ8FoMLfHXc6BoVZ0TpZrUEtXfaEmpRb8OLiCScXO9HZjMtVyYrg9RLTDBFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AfHkA/fv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AfHkA/fv"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso20302615e9.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 08:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783351755; x=1783956555; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh+EaBgmuYdNNpZcqgX7l88URVM0gQj+bKH7LdozPRw=;
        b=AfHkA/fvL3A/rk7KwsBj1Hx/r9dskaifpZxY+7jjR4KV0wrOlC6zKT8JW8wLXoK+i9
         eEpd3YSPrI/K1ZoyaIc8cISOUl94+fIoo2yNvxoWCyrjkO+ywnHXRsEOzS8MH3LrJ+VW
         fYglRgDKJfQZy3zyuy74RthRouhVRfGgxSqjw1E//FpBH+hcRnxUd2gxb8WxOIxAsgD4
         s3fwmmXNKXeWRbLh8c0d4KO7RDfaxnx9XXea3qoBslnLZHDOZkDhOTIJNCUj+F2Hxieb
         ksGrUHJceoUzLe7OPBG3VUPdDJ1LhFTF7R1U6T4KOCQqGeplvG/4CUasBxCA8JagJqHO
         snPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783351755; x=1783956555;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qh+EaBgmuYdNNpZcqgX7l88URVM0gQj+bKH7LdozPRw=;
        b=fY1u5uNI7V3haPvMtld4NQMAzBOvovXg5C8VN386ZWiFwvgnkl6wrWBSe+mTk+nuP2
         fnkGEEVwZC893efDG5xmyfMdjUiPyyKEdcSbyNLxF3jmckEf7NbcLslXBNFPlQNAwBHZ
         QtLfL4KvXU/DQGLKdIcSJxTe7AFn6se7jSNf0yghtv22nLuvbTdlfi5mUQ1ShHnT+F8M
         VdR0O3gKrLnf+PhhLjk0N+mkSIf4dC7FI5L73GAsCqnOVmzz6QGhAMPKNfMQcs83mEyO
         A7zewve3ZDUPh3GP8uBBU1VPHKCXex9UYHEYV+CUaSF3x4Ap4rlkeUTd4JAXSUcwvd+e
         6Ncw==
X-Gm-Message-State: AOJu0YwjmuWwpILhNhbYwd5hzzlyfaO4gn8HkDrFrx586FbblkBkRvGp
	06eidgHIozhDUrIwyNL6cJW+JEETb0FKq/sf/QFX/cckMYOHJNFqvQXsj6FhHcfLvxg=
X-Gm-Gg: AfdE7cmNBWDgJPP3E52ACtc2DdFqrzKJKoVVN3/V1BmGhxd6ZSf6saL7e4YfMPTu7QF
	A7PAMUFqEbV5O98lAUF2qjLMNcczwGPsbVgX2H0Uu/Sh8OFcOgaEQMLqy+6chK+y53PZ5YXczF1
	E2cAIR5qpcU2UsLFcZ02hk9BEGkfeskQgFIknN55IUHkU0lIiDpbasMMlsiaJoQ96Mwon+zC/eT
	380Y90sWs114nsQ3AocFd3Rz2/yvbjo8yvI04Yal4E7GebsYiUO/zcMWss8EO+rLwuUgpbt8ZA2
	x8mu66zC6W5VpGOa6xdW6ftEAF/QFF7ZN/hOLqQdi7TVnr2kFErbWYsWX6UQKIFGslhVDYHrONt
	nUEyo1AciskgA7tp6USZIxOlDCbJ6jNTLSw/KBqrecHw8Y9SzezhnfNafdD42ufYeh9bV5Ny6zm
	4nOg==
X-Received: by 2002:a05:600c:3b2a:b0:493:df47:8d9f with SMTP id 5b1f17b1804b1-493df478db8mr3788435e9.10.1783351755505;
        Mon, 06 Jul 2026 08:29:15 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:157e:cc5f:6c4b:db0a:5d2a])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-73e19f3af52sm5839852137.3.2026.07.06.08.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:29:14 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Jul 2026 12:28:43 -0300
Subject: [PATCH] docs/bpf: Document BPF_STRICT_BUILD=0 to tolerate test
 build failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260706-b4-bpf_strict_build_docs-v1-1-5324d605c7b0@suse.com>
X-B4-Tracking: v=1; b=H4sIAKrJS2oC/yWMUQqDMBAFryL73VArEkuvUkrYxI1uaaPsRimId
 29sP+fxZjZQEiaFW7WB0MrKUypwOVUQRkwDGe4LQ1M3tu5qa3xr/BydZuGQnV/41bt+Cmrwith
 FbC01EYo+C0X+/NL3x5918U8K+egdD49KxgumMB7TJDxwOr9RMwns+xfDqGyonAAAAA==
X-Change-ID: 20260706-b4-bpf_strict_build_docs-a8aa7fa46e2f
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: bpf@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1783351752; l=1578;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=x5HuJc8ryRcujdAvfssRfuCUtU/zCfH7JZqYpQDH/Ak=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHr+osZxhUqq7pE2zp7ADICTSyXNXxqw773pIlwgLCWR9KitoP8KxoHnsuxC5prSUiXwEd4ESYq
 f3uzdQk9NIQU=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

When the kernel config does not fully match the BPF selftest config
fragment, some tests may fail to compile. BPF_STRICT_BUILD (defaulting to
1) makes any such failure fatal. Mention the option so that developers are
aware they can set it to 0 to skip broken tests and keep the build going,
which is particularly useful during bringup or when testing on constrained
(e.g. distribution) configurations.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 Documentation/bpf/bpf_devel_QA.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 45bc5c5cd793..edf8107a7beb 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -479,7 +479,10 @@ for details.
 
 To maximize the number of tests passing, the .config of the kernel
 under test should match the config file fragment in
-tools/testing/selftests/bpf as closely as possible.
+tools/testing/selftests/bpf as closely as possible. If not possible,
+however, you can set ``BPF_STRICT_BUILD=0`` when invoking ``make``
+to tolerate individual compilation failures and continue building
+the remaining tests rather than treating each failure as fatal.
 
 Finally to ensure support for latest BPF Type Format features -
 discussed in Documentation/bpf/btf.rst - pahole version 1.16

---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260706-b4-bpf_strict_build_docs-a8aa7fa46e2f

Best regards,
--  
Ricardo B. Marlière <rbm@suse.com>

