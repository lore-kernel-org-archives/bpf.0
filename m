Received: from mta0.migadu.com (out-53.mta0.migadu.com [91.218.175.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3BC1429D
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 00:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787184418; cv=none; b=nQZWlG59MA+J4RI5wijPa+QP19DkwlCR0Xe5ghRwuLVuxnFmx3txGRe3DepeRamYPjy1CSsu7EciDb0ZZOWWBM113LnhTWRZPTkF0Wag7qX8fhEApA3sYhJNAH1tSOy8euWjRGpTdB3WJoQuST6df3bge5oQE5GEYUIBwestJg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787184418; c=relaxed/simple;
	bh=SdV77KSxnrHvEFX/CUF4ChbQsWcZr8Ltos+JDdYjLrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYWsJzy8uyKWheEoycHG0r32bKJQNz+MssdDNSeSij/aZsb4khGr8qv11bI72jw+S2ddvCrcbkD1OeI9fpVF/dXCYfMb4fbcs65sbO4pC/uyBG0aQ3be7vPR2RGX7YcrEx+3Yo1Ig9HW1LWgH/moeZOp6TmU5Xx3+CAP7N5A0Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gco8yBNr; arc=none smtp.client-ip=91.218.175.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gco8yBNr"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SdV77KSxnrHvEFX/CUF4ChbQsWcZr8Ltos+JDdYjLrE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787184415; v=1; x=1787789215;
 b=Gco8yBNr+jXyLy+rrlpVkEupM3ZzFhbZaL8I6kjoGizqZtpsSWPcOii/tWpoUcwBEVU0ombm
 vPy7xcpXlTZfL7kzlQLT4ATQrQU6Ik6zDbPTUGRa/U0Nrzu54VU8RsWu5G2jTMYoLUy81Jj6fvo
 7qd6k893M2uW7kQkD5Ev+J7I=
X-Envelope-To: bpf@vger.kernel.org
Received: from isolodrai-fedora-MJ0FVMD1.thefacebook.com (2620:10d:c090:500::5:942a)
	by mta11.migadu.com with ESMTPS id a8a0046381649d78;
	Thu, 20 Aug 2026 00:06:55 +0000
X-Mizu-Trace-ID: a8a0046381649d78
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next v1 3/4] bpftool: Don't drop a type in the sorted C dump
Date: Wed, 19 Aug 2026 17:06:26 -0700
Message-ID: <20260820000627.3826188-4-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
References: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The C dump sorts types by default, so that generated headers are
diffable. The sorted dump emits one type fewer than the unsorted dump
of the same BTF.

dump_btf_c() starts its loop at index 1 to skip the void type at BTF
type ID 0. That holds for the unsorted dump, where the array index is
the type ID, but not after qsort(): position 0 is then the lowest ranked
type, and btf_type_rank() ranks an anonymous enum 0 while void takes the
default rank of 10. So the enum is skipped, and void is emitted instead
as a no-op.

Skip by type ID rather than by position.

Fixes: 94133cf24bb3 ("bpftool: Introduce btf c dump sorting")
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/bpftool/btf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index c9589026da8d..345d49a9a22c 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -805,9 +805,13 @@ static int dump_btf_c(const struct btf *btf,
 
 		if (sort_dump)
 			datums = sort_btf_c(btf);
-		for (i = 1; i < cnt; i++) {
+		for (i = 0; i < cnt; i++) {
 			int idx = datums ? datums[i].index : i;
 
+			/* type ID 0 is void, skip it */
+			if (!idx)
+				continue;
+
 			err = btf_dump__dump_type(d, idx);
 			if (err)
 				goto done;
-- 
2.55.0

