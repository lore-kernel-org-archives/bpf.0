Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248883;
	b=uiLIz/MHLTOlMsmlgCym+FHaclonyiU5AE2ZoygUBDP9he6eId+AzI4TSP+30jH3qtHY
	 teXl5oEHqxqgS4MTztmCmEPrftdRWFxyl0IpUu8sRXlQUA0PhIQqPmlBn7EDQFb5sIG+W
	 9v0l/dZHIOeQg+6UHD+Amnsa6Lbwt8JkMV0U121CiDksAEdErB7LwbktUKDTrgRme6mRf
	 CLL6kBA1aqfXp0//WK9HLngreD1FBcEzUD6oacCmkJH5n15J6c/B3FcCEfrWeOtNPaC5Q
	 Y0QKBmyYRtldrC20pRZjwN9ha6Ni/cX+ZrxYbbE/A5PaESJVh8OpG47UiV+oYVxNilQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248883;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tTolH0o7QRCBVU2804gfsGiaRlD38BjNVXmMOT4iXgQ=;
	b=N9qD4lt1ymXwukYCAZ9FVga2AgH+IQBQaV1lclcVx65CH3EZHU5eIhv/HzvFSA33zQ+K
	 THpWUM9eF9spzvUOqvi8BRaBftasLZMzIlMOKAXWH1MdZB6BmzdOgdewAds3uwf0kFg1J
	 0XszBRqW1vrWFpqUqj1RXketmnWDpj3k42uZlPc3f1Bk6uPQi5mDHKIoiOXjA4GxSe9D1
	 U6WvHCdhMHNMdD9Ecd2QSWPVaO3vxZxdWNt4T5Fnxnqws5gS2kLwG3w80E620+f4in7JH
	 En3N0BRaQDhEewc4TexWe9KFrD5zfk5vkeqhMggw3DS6CPUWi+ITAY1SezhnlKuSMHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="et+/0fhC";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501FC606E110;
	Mon,  9 Nov 2026 18:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 501FC606E110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=et+/0fhC
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6093C1BD0;
	Mon,  9 Nov 2026 10:27:58 -0800 (PST)
Received: from fedora (LJ9QCPV96V.austin.arm.com [10.118.150.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46A143F882;
	Mon,  9 Nov 2026 10:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794248881; bh=35IbfdKltgH8SiL/vYtmwWbu9GJaRFKqy/syCjR48JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=et+/0fhCsJpdG7vxv75dFZ6synhrxOZSYY/yF1jJ/DVFfVc2RUfR44sTcsWcgoPpK
	 IzPJpdp8DLkDJQYyYusVUGbLvArUYC98BkVlKqxXQZqMl4GS8uL6pY+H2PyfM5+RtO
	 yxCQf7EOug254IBnFREGknlwOboScTs944RJvt7A=
From: Bill Roberts <bill.roberts@arm.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	rick.p.edgecombe@intel.com,
	Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	x86@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Bill Roberts <bill.roberts@arm.com>
Subject: [PATCH v5 5/6] selftests/x86: support header files in extra-files
Date: Mon,  9 Nov 2026 12:27:57 -0600
Message-ID: <20261109182758.252223-6-bill.roberts@arm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109182758.252223-1-bill.roberts@arm.com>
References: <20261109182758.252223-1-bill.roberts@arm.com>
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

The extra-files Makefile macro uses its file list both as
additional compiler inputs and as target prerequisites.

This prevents header files from being included in the list,
since they would also be passed to the compiler as independent
compilation inputs.

Exclude .h files from EXTRA_FILES while retaining them as
target prerequisites. This allows tests to track header
dependencies and rebuild when those headers change, without
attempting to compile them independently.

Signed-off-by: Bill Roberts <bill.roberts@arm.com>
---
 tools/testing/selftests/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 407f52ac2628..effbfe9b269f 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -115,7 +115,7 @@ endif
 # the dependencies ("header3.h"), because clang, unlike gcc, will not accept
 # header files as an input to the compiler invocation.
 define extra-files
-$(OUTPUT)/$(1): EXTRA_FILES := $(2)
+$(OUTPUT)/$(1): EXTRA_FILES := $(filter-out %.h,$(2))
 $(OUTPUT)/$(1): $(2)
 endef
 
-- 
2.55.0

