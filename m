Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30844D6C28;
	Fri, 25 Sep 2026 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350932; cv=none; b=FcUK/QyaQo/pufaPvPSNZQqS6t86bj5gPIGGWSHFEwwqX3yniqgEd7E/90Z8EwyGKAoR8croc0LMYlc3I0dkbnMbghgzPmMgRih6/mr8S5OiNuly99Q9we5V0qTW3fBPA2w5cbBSCdTXy/I3qYTbm8sylCjsdDqB8vWBJqixA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350932; c=relaxed/simple;
	bh=jlI4uFZ1+8me2NuVmZdJ+KaPtqDI/t29a76yy/AHuNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBG0DY2NHsDlSIk1GoiqqmNh3HY/Ct2Ts6W7VefzKo/Q4stf/IJuvIVamiCVWpx5wNo5UE1RPwkq+ffNG9YsCRDJ5wkmLDH2mFESGQCZ1LTmMNIzjh7WQHU6WsTg9v/HbbQENMw/XGTMPc4dXDMOirA19aQTx2ecdmIAlblhi3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=l3fVFBu/; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="l3fVFBu/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=W4ii+hKohbIxnshLLq0LWJvtdAVeBF2GqIkooEFXTXc=; b=l3fVFBu/YgMK
	zbD9ioig/bqttHLts3yA1Y+yl7rXCw1dHEoUM4jFyHwHjRouO6dFaNLyhGKUZFaEfHX9n8tB9USfD
	Fl/gTwf1u/LzBiNhJExaxCOxERFw+rqIvH+wH/at8WQcfSjP4SX88bKXQoTJyYQ6ZWZ4Rc/OF49x6
	yWDBase/+cHE7ltoF2JHaPyB7P7I4w5hLBPVUC5g3rCeGF0LUm3VC0zSGXzyB6nR6zufY93hiKVvE
	m2JyXRE7BaiQ9inYT78VS+JL8dsDlLQlShlfNUJJEhi0giNmhpOhpNAE1UoDoUGzrEOtoBVqCalFJ
	3eZoccYKJnHXW8/bQl1Y8g==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=LekKit-T14)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <eva.kurchatova@virtuozzo.com>)
	id 1xA80d-00AsiD-1P;
	Fri, 25 Sep 2026 17:41:47 +0200
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Cc: linux-kernel@vger.kernel.org,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 1/1] selftests: bpf: size the map in test_lru_sanity3 to whole refills
Date: Fri, 25 Sep 2026 18:38:13 +0300
Message-ID: <20260925154029.3673513-2-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925154029.3673513-1-eva.kurchatova@virtuozzo.com>
References: <20260925154029.3673513-1-eva.kurchatova@virtuozzo.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_lru_sanity3 fills a map of tgt_free * 2 elements, and then reads
back all but the last few. Whether that passes depends on the cpu
count alone; on a machine with six it does not:

  test_lru_sanity3 (map_type:9 map_flags:0x0): test_lru_map.c:463:
  test_lru_sanity3: Assertion `!bpf_map_lookup_elem_with_ref_bit(
  lru_map_fd, key, value)' failed.

The kernel hands elements out in refills of lru->target_free, which is
clamp((size / nr_cpus) / 2, 1, LOCAL_FREE_TARGET), that is 128 / nr_cpus
rounded down. A refill the global free list cannot satisfy in full
calls __bpf_lru_list_shrink() for the remainder, and that evicts live
elements. Filling the map therefore evicts nothing only when computed
128 / nr_cpus is a power of two. Any other nr_cpus variation fails.

batch_size is already __tgt_size(tgt_free), the refill size of a map
is __map_size(batch_size) elements, so size the map that way and the
fill consumes whole refills. Start the keys of the last insert at
map_size + 1, just past the new size.

Above 128 cpus __tgt_size(tgt_free) is 0 and there is no size to build
on. Skip the test there.

Fixes: 5e9388f7984a ("selftests/bpf: adapt one more case in test_lru_map to the new target_free")
Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
---
 tools/testing/selftests/bpf/test_lru_map.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
index 0921939532c6..84e9a930471a 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -441,8 +441,15 @@ static void test_lru_sanity3(int map_type, int map_flags, unsigned int tgt_free)
 	assert(sched_next_online(0, &next_cpu) != -1);
 
 	batch_size = __tgt_size(tgt_free);
+	if (!batch_size) {
+		/* More cpus than this tgt_free gives a refill for */
+		printf("Skip\n");
+		return;
+	}
+
+	/* A partial refill shrinks the LRU and evicts live elements */
+	map_size = __map_size(batch_size);
 
-	map_size = tgt_free * 2;
 	lru_map_fd = create_map(map_type, map_flags, map_size);
 	assert(lru_map_fd != -1);
 
@@ -466,7 +473,7 @@ static void test_lru_sanity3(int map_type, int map_flags, unsigned int tgt_free)
 	}
 
 	/* Insert new batch_size: replaces the non-referenced elements */
-	key = 2 * tgt_free + 1;
+	key = 1 + map_size;
 	end_key = key + batch_size;
 	for (; key < end_key; key++) {
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
-- 
2.55.0

