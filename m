Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31837DEB2
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 05:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789103581; cv=none; b=tah6g0siZ91D+cGr+ZEc+bFjG74bHiltIMKsd26DoGz0Gk/7dmoJQARNL9lxNM43XWqjMGWF1zIaZ6rwhuMuBkak5fOPh1FgTGxy62ycfujI58X4pdlUqoode/9V6FyCC9kXKW9ZFUvQXO68UVwve7pd+szY122wcchbzzA6QjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789103581; c=relaxed/simple;
	bh=m3lPXZNnA996zszd8DuLG8P9OW5dv8BQxG5hl7wsYrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BlJxJiw09eQoHYy1C5hf+iU5uDfMi0rCI+Ferao8MOFWI0BCy0yKMKG9/pKzd8kV9u5/9KgqJniqp0F0RwJe8bAssX6mL2ynlgeK6ODhiP/KJSfmOi24SXU42ncb99FYMvUZ8Kqt0ekxCo69WBfSjG7iQEqJcdRTNt44A9zahgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tHg4X7+8; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHg4X7+8"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-398e10200a6so272842a91.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 22:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789103579; x=1789708379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m3lPXZNnA996zszd8DuLG8P9OW5dv8BQxG5hl7wsYrI=;
        b=tHg4X7+8Ejmf97rZ0fCo7Zw2fTZUZMJouktH4BMv8lQvXTzhhMcHKC14L1OCROGuXl
         Bpp0UNhcMoRLvytSY2c5xhNZ6om1WlK+aVhkLbMzZoXLR5Y1mSTEuOIscALY4lWR4xnj
         DGO6LR4TF7asLJryUuhuKZDfvQqtHfMHDttiYBlfD4nyF96XO/FZag4hWgo+sI6X0hql
         h10TAPaUHVbMfE1kkIbl6H4Gfa50bNsyTGemvl7vqhC3ZkPSqg0UoCkYqTohMy9Zhty/
         VAenCbA/3dQ8qG99P5me1m7SYwiNSG8oh/gGh0gKkC/R8gye9qFzJZC1RdVTQNE5alEm
         jylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103579; x=1789708379;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m3lPXZNnA996zszd8DuLG8P9OW5dv8BQxG5hl7wsYrI=;
        b=OYDoY522vGK7UHXpybeJCZEY8mA7tY53bSBu8LA16nSZZrSXsEi/6gkXsXevDNqeEg
         ViV4hz7FDHZ31ljcwMa/h36H5xxnZ4XtrFsT7eaFPtVB4PVdqRZ4XwhlrRvdqpcs+jas
         x6R5O+lqXx52WDA6HVTAd1D6DXqAZHF28uPg03dD2+o5OaS1P/DxTQ7pAU4y9Uhkg6+z
         lJneWQUe4wJmE153G3AtLaZtsRDBuXheStVhuo4kFV+ZJaiE8z+0O02PYJFvcds5Vh4n
         w3qhVTUFL283Bo40PJWi0tMWkvVCxdFco86Jn7eCJBcaor16IKx3G/2qoaUM0MxL3kRS
         cFiA==
X-Gm-Message-State: AFuF++lT+AM5rlnrABEo0cLe/aaD06Cd26nUeDHMBtV8pEm4QELirCBO
	AH4QsG5k49GyYS/V3Gjz/Y6F/PUzp2kh7+ODCB7Yh117B3unXrhF3ATXCgAnfpSdoeY=
X-Gm-Gg: AYBFou11xe15Htlw2siPWnZJOSIR7HM8unFLYgd3pCUcpgGVlgVuorzRCR+wzAj4mxp
	X6T6+h/7Er1yH4v5FVzMbi6OLwYTgfjQqqkK1ScWt76y/oeoqSQHd4ePH5eA7KtSdFCwD6R+D5m
	BHU2/zwe5aZdk6FtU71ORfj9AH855xePAPan3+EVW5W3aWkC0/TZFmIRWnoyrTEZic1Q9Idz4Ae
	5AI9miI8jY7bJZl/OAWIE7gTyTc7clBdl464vbJBwchs7gF6FqMvf8kke14/WwA2YMWpWyQ+C8M
	RI2TSrSGn2aHuAhK2D9uYRlTdW1xbuyBTm3QjSHv2hf4egPjhIkdjoGMKodfN6aOtP31dzQbaIY
	Ov7XfMxfobkvOmItMnzDyPvjws86vD/z7qc/2H7GqP1XJGebqK0I1ikwkIdyOa6x1NDmqeRgpx4
	qvXLSveRbdb6O+BeCDXo7n4kPUAWJDPq5jjL2yZQNI
X-Received: by 2002:a17:90b:35d0:b0:398:c724:1bb1 with SMTP id 98e67ed59e1d1-39d9bd91016mr4090723a91.8.1789103578599;
        Thu, 10 Sep 2026 22:12:58 -0700 (PDT)
Received: from fedora ([2602:f921:f20:17::a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4cf015csm3274601eec.4.2026.09.10.22.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 22:12:58 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Cover recursive bpftool map dumps
Date: Fri, 11 Sep 2026 13:12:42 +0800
Message-ID: <20260911051242.284102-1-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911035503.891321F000FF@smtp.kernel.org>
References: <20260911034715.219552-1-diannaaav@gmail.com> <20260911034715.219552-3-diannaaav@gmail.com> <20260911035503.891321F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bounds check is useful, and v6 now checks for a negative snprintf()
return and truncation before advancing len.

I have not established the reported overflow in the v5 fixture. The
loop has exactly four iterations. Even three maximal elements strings
and their JSON wrappers fit in the 32768-byte expected buffer. Only
the fourth append could truncate, and there is no following append
using that accumulated offset. The actual fixed maps are much smaller.

The explicit guard makes this safe to extend and reports truncation
directly as a test failure. All 12 recursive-dump subtests passed,
including the multiple-root case.

v6: https://lore.kernel.org/r/20260911051053.283421-1-diannaaav@gmail.com

Thanks,
Tianyi
