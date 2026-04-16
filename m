Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788D722A4FC
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345203; cv=none; b=Vga7oTulwctaUmQU/QvxmZKruP4UnGCmeawn+IHPA1pEnJuu0c+rC5ZbjWWm1xAAlqHMtNXS9G57RZQJn1xOFZ89HqCku8tpnqTTkF0UUgRBSisrlmVgNCPGAbsosOlR/WOn/HT8ngXdiuptoAWXpsgf1fKQZ6NScPCM8SBwVGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345203; c=relaxed/simple;
	bh=UolN+nLHbjLtgmFPrv286FMuRFO8aFj8iJqngA2W2ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgSDc1dieCtOzvOlrXUC2IdC+x+vPkjLY4QtD5Z4+exgpowXiNaI6JkbVj22pbCGce4IR+bfOTr7oig0CquaMg5pwv2WMQC06ptiAUOfNpl5tO5wh1kdaJaoXT0PO4pmduWfATOPLxLnwierHJoXjp41kUw867QsrGpwpY1E9cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW94Aq78; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW94Aq78"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so76134395e9.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 06:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776345201; x=1776950001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wolX7E0HmMdkoEPT594V9SFbLPIirUrBiiZiI3J61SY=;
        b=NW94Aq78Y0VQEWS1LIyWhOZj0HszJqp5X5MR79DvZGy7L3Vkp80srDHHEq0UuATUfF
         WaSa10QVAXpt2g4XqRffpqe9CajKVukUNFvbUBQ25hj8PLPHVICkGvQ2Dz8X0LR9yPZd
         1CKbuysgCOjamu83qyn5zMg0cv+huTGGMAMszIvx+N6zpoH7H4Dn9hQ/2dkAbOGvWYnF
         woaKeaxKYlWx+WCzuYlZqQzcR16iyuBItaEkjEAguAtf4hCBB2+t+s7sYrxwl+LR9Fut
         Ns/e/g055LUXgMp5Fn9w5OrYoI7d6LLGKYqqKvN+gLw+vQYQddSrCZO4apUoV5FfL8+/
         LxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776345201; x=1776950001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wolX7E0HmMdkoEPT594V9SFbLPIirUrBiiZiI3J61SY=;
        b=KYNBkjivVR7POOnBTrkduKvTLPvx+IeAhRsqmN5EXm1VVOlq8OE4DBL4q6NO2/1mbp
         A0bEJgKKxXfuRl10FpOOdm+z9e/j8hQG9GQxbQBUsC2w2gWx00fGmWtvMB8XdAV5m2sm
         a3v3LTsySO7bh5f98+bc7T8sEKXMcJyRtXzHlKtSQ16hXetLHJYfQE5B9FurbY4tg0o3
         ncxnJt/c9+xor9pk0JUl4Kz+IT6Xh5F7b8NVZiyHQNee+QWHULmogY9myjN4xbd1DYJi
         ZESjRiKAiCCb5INMDIi5ikPnlOKBqJC9YSzcOrzo7CZRiHUxm4X0TLrvRqDMs2NHF5Wf
         S5iA==
X-Gm-Message-State: AOJu0YziaeQy7EmJ34IOLxN7eDHyt2WeIxTW6icXZBRSamZVV4c8fEMc
	TZwdZ3JNhifGNhnk5kFvZM1jgGKjTQr7dhhxblL7c/LqTGxyAWOmF7vUF6F6NxFO
X-Gm-Gg: AeBDiesFfLIKVoNbL9XL94IF3iv0z/otC2UlY8bQm0ERdkz+ym9QhDfVF2BFRcbAj1y
	uTbtfQHUhxLZLxMY9nJfK8F5wZy9VjwHeg1C25uK8lBWlnlVblhaCrCos9eidz7pScShB3Co/OZ
	8v+/FzB3oq87RqrfzShAvrvKe0gAFHglACT4kRIMfUFGgQMS77YqsyRit+G2w0iSm6fQWm5fSld
	k6Nw8MYyeyKS9beAH2/+G0l/isPti0a/qmuzU5Qt12V40+Ho96MmP7W/3F4klcf0hZfp0R2y1tN
	IVsnfnzI1uiqVhT1Fp3FL7smh+iVDhfcNA/TONZCufqox14BX+iDAGFYEM+oHiUOeOnJQbY3Y/r
	uf120WemD69ydT7+1FgG0KG4+I3Evu50S6Qnx1esof8EH0E6z4yxYk/gZdUrHXZr91+YyALntyM
	ae1KZFYKHASf6opzC2KwFyHGy3IlvkzXgBSmij8x51h3G6rv/+1Mvcy6ms+fiKktdyK1O+sVasK
	LfppLRaxW1eHDwJOzR2GYKoyavxhFb5CXOXcmQweY7YYWEKWFQ1plX0yTgnScMvltnfijMoNlLM
	8MIYicquB2P3pP/QgdtCDJlptsvzyjex1J0ToW3N/Wg5+NksMTR/
X-Received: by 2002:a05:600c:45c9:b0:488:869c:edaa with SMTP id 5b1f17b1804b1-488d67e269amr363975925e9.7.1776345200728;
        Thu, 16 Apr 2026 06:13:20 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b55a04a9836ebec0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b55a:4a9:836e:bec0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5827da4sm50621075e9.14.2026.04.16.06.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 06:13:20 -0700 (PDT)
Date: Thu, 16 Apr 2026 15:13:18 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Helen Koike <koike@igalia.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH RFC bpf-next 6/7] selftests/bpf: Hardcode insteresting 32->64
 refinement cases
Message-ID: <5a9c7310fcfb8252c91d34396e9a015862fdd02a.1776344897.git.paul.chaignon@gmail.com>
References: <cover.1776344897.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776344897.git.paul.chaignon@gmail.com>

These test cases were part of the slow mode and failing before the
previous fixes to reg_bounds and the verifier. This patch ensures they
run even when SLOW_MODE=0.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/reg_bounds.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index d38550fc1624..dda5745e583d 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -2246,6 +2246,13 @@ static struct subtest_case crafted_cases[] = {
 	{S64, U32, {0x0, 0x1f}, {0xffffffff80000000ULL, 0x000000007fffffffULL}},
 	{S64, U32, {0x0, 0x1f}, {0xffffffffffff8000ULL, 0x0000000000007fffULL}},
 	{S64, U32, {0x0, 0x1f}, {0xffffffffffffff80ULL, 0x000000000000007fULL}},
+
+	/* edge cases for 64bit refinement from 32bit bounds */
+	{S64, U32, {0xfffffffe00000002ULL, 0xffffffff00000000ULL}, {S64_MIN + 1, S64_MIN + 1}},
+	{S64, U32, {0xffffffff00000002ULL, 0}, {S64_MIN + 1, S64_MIN + 1}},
+	{S64, U32, {0xfffffffe000000ffULL, 0xffffffff00000000ULL}, {S64_MIN + 255, S64_MIN + 255}},
+	{S64, S32, {0x8000000080000000ULL, 0}, {S64_MIN, S64_MIN}},
+	{S64, S32, {0x2, 0x100000000}, {S64_MIN, S64_MIN}},
 };
 
 /* Go over crafted hard-coded cases. This is fast, so we do it as part of
-- 
2.43.0

