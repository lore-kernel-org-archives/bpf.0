Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658EF3EE1E5;
	Sun, 16 Aug 2026 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920480; cv=none; b=L0O055x+N5SkVjhlknujJ98xoqeEADb2Khe/93MCIgLmmgLft+pHDv9jZ1X9hc5qBleGbkIkhODzJwTH+0nfOXdKLEoUAu2Xv2PhFBUSIVpa9waHT+zKrcFNHJw5qh1Cfluazhvj5rwywNFjb8cwh6kCI7GIGQPwLW3vnB/kV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920480; c=relaxed/simple;
	bh=V2amMiMl7R+h4dDAD6Zy7w5nkocePltmqZVhOP7JMNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNASkxTpqSo5VGJ0WWKQRDAtbc9y4L+k4FU1eLRqs0b2tPjpicjBPaQsqIlkwIL3z7D0xOZUanVkVOAJFb1Ezp91F+h+9XE8G/cstHAxkQPXn5pJeE+eZKXXlXnodp5JNZp0ucc73lhCqq0Lqovo9zjqSUz/9rQjzLd6MSmHQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=0KrLNBOp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fwlDkpgk; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="0KrLNBOp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fwlDkpgk"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 692D5EC0074;
	Sun, 16 Aug 2026 18:47:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 16 Aug 2026 18:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920477; x=
	1787006877; bh=pI4lY+AJfKOOjXvPiR0jbn4HyML/QwSMTUaiVyOT0As=; b=0
	KrLNBOpYOPbnXg5hm7ina1g0ZHCTyNqP/VTFRHVM6sdgshZ2wVN2j3ej2iBzttnh
	NAFDGpntTkBz66SHNLaWbBOblPFQCR+VRnv2V9DPWGeCv5mV9baYtrFc1BbgMSev
	HrZSAsUrzTpuDBvQAfhsbtKU1sVtWv77Hpc3bl/55w+FTA5CBFcsQZwa8qNvjS9y
	UA/9nHSkwNijJDlcDkAjGQMwh4ZuG/UIgy1abfmtDFrbBaRzBdjvSB1iLO7s0ccE
	iL85a+IykYR7qjP+C2ouXneVPivWKeNXjgoL4dE3WJb4TboXzECfi7IQzvjvYPiC
	87hASIGf73zI5ZtJaTqEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920477; x=1787006877; bh=p
	I4lY+AJfKOOjXvPiR0jbn4HyML/QwSMTUaiVyOT0As=; b=fwlDkpgkeMZAR/C/C
	ZHIYGibmR+6BagltMa4AF34xr2PMsy5NRw+2XrmedxKjk3KU+BKe3dGZZ2a/c44F
	Ten7qAoPkTuUp9RW43eRSwxioiaEELXeJ/LPc9gwYawfdl/BJZbACsP9JDuEf6oB
	Wtvdge7jFJW7ZBqHTQM0Wyvvq9Ee8bkKb0DQr1cQy6ymOJ6H7+CX+twmnrLXi5Lp
	nfIWtZ9yeTCawpc4qzNfqq3/aRLrxfoOYUnpz7yK2pHtLUYiLCBuyHR/po/ALpbW
	yS20oqx9rvGQqNSCztj9W2NjE/igqtmYUoTwny+hAuIYNNMGe7F8zve174pc0AVm
	HCUnw==
X-ME-Sender: <xms:HT6CaqfyvV1vIi4cPst5XmFoYwVTFj12MYVAmADUns_pNyquOFwaBw>
    <xme:HT6Cat49Y_M7YC1mCQsfunNnGQ_3gaTp4CsJP6PQXp1aHFXIf2gMcJn6-6YONiTB4
    Np8Q-v1GtiR0G8XnNFhyKFgRDXgWfaU_RzL0AgNZ7ncPrZ8WQezqMo>
X-ME-Received: <xmr:HT6Caq0M4FYaQoZVQAo61i8KRQTbqjCb1K7aVDDpQjno9AKOcBYWBXEoCYA>
X-ME-Proxy-Cause: dmFkZTFX8QZ1Abcp//ElmtP0wYUsUMnb+KjPA544aOlJXhXcQAudkXa81C9Rj4L11ediC/
    SYpDnD1LvcyFEAv2YFQNL3ReIx6t28G7cFOXvsWQqNdQRv24cIelnnbcWrHqur16sY2q+b
    PHK84xbhjrx0R6ZFbdj3lDcQr+wbYteZ9PHsSvZgjQoovnxRkTlpJXxI+K+aK0DY9MqaWr
    nM0jSjvJAOtmNeFdTIuI9VxKMOFqeJI9DUUNBafqnTlsaU2K5w1xy/oDJpRmozGKRfcEpJ
    T4FDpTcqBKNo58tTW6I4nVl91YkYNyFfziYdH6IV5aj62MGBqsSUtSYZnaDODTOndFzTg4
    3gj7NdlC8U/37zfIU9cOpYnuRdXqkl9pVUWc3zwBpKJzvj+ZfRQlz7GS0Ejlp3UR3S3OSR
    Yd0A+lV4lpsWSXukhEFEBp0eGov5qfF8JzT+PPjVG2KIhEnHHbHIxwPmWbz8OxyU++EsAh
    RsLI86qe1gASncpfU8bRy6B8cY8saqXrUVybVt5nqWgtzw4IJAa+6Td5Hbmb1QRUXlJbJx
    GkafdYrgnhVsK1vDbEOoEqpzGn0iwNtltfuGQDQQEbiiDEAB8frR5GXA+RVgD6DnVcpjQT
    3C3sZmLkZkqv6ZVIOyP1kW5sYHRBNe9OT/zSKApbEQuHaXzBQYMRjgclBtCA
X-ME-Proxy: <xmx:HT6CagDyRQ4RhvEfGzHyB3EK742G3n4Cf0ippH7ddVrL0Cz8rHjG5Q>
    <xmx:HT6CarFe_F_su38oOgOf65C28ts1cZwxARcLL1t57AJm7cbUPCxvrA>
    <xmx:HT6Caqr7rAE7UR6Fz2MUQmypgCjJtDE4nkuSV6Tazj-PPVmoh0t5fQ>
    <xmx:HT6Car1ATaoqGe7PghNyWRYplbjHgWERwim0QIUKm5Fxhc16Eglevw>
    <xmx:HT6CavShMTfNJOFUXfFUaZCLyVx8e9_g9EfRz-XzhNxAflfK4Nd0UpGZ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:47:56 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	nico.pache@linux.dev
Cc: baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	dev.jain@arm.com,
	hughd@google.com,
	lance.yang@linux.dev,
	liam@infradead.org,
	mhocko@suse.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	surenb@google.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	ziy@nvidia.com,
	usama.anjum@arm.com,
	agordeev@linux.ibm.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kas@kernel.org,
	jannh@google.com,
	willy@infradead.org,
	pfalcato@suse.de,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC PATCH 54/57] selftests/mm: cover collapse beside a MADV_FREE'd page
Date: Sun, 16 Aug 2026 23:46:06 +0100
Message-ID: <20260816224609.308019-55-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816224609.308019-1-kirill@shutemov.name>
References: <20260816224609.308019-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

A clean lazyfree page must not be collapsed.  Copying it into a folio that
is not lazyfree would quietly take back memory the process offered to the
kernel, and reclaim would no longer be free to drop it.  khugepaged
refuses the window that holds one.

What it should not do is give up on the rest of the table.  One page a
process no longer needs is a poor reason to leave a whole PMD's worth of
memory without large folios.  Yet refusing per table is what khugepaged
did: any single disqualified PTE ended the scan.

So collapse a table with one MADV_FREE'd page in it, and expect three
things: the windows beside it collapsed, the window holding it not, and
the page itself still backed by an order-0 folio.

That last one matters because selection descends orders on a refusal, so
checking the target order alone would not notice a smaller window
swallowing it.

The freed page's contents are not checked -- reclaim is entitled to have
dropped them -- but everything else must still read back.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 tools/testing/selftests/mm/khugepaged.c | 44 +++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 208300ecb344..58cb7364652e 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -1685,6 +1685,49 @@ static void collapse_order_sub_pmd_holes(struct collapse_context *c,
 	ksft_test_result_report(exit_status, "%s\n", __func__);
 }
 
+/*
+ * One MADV_FREE'd page must not stop the windows beside it from collapsing.
+ * khugepaged still refuses the window holding it: collapsing would copy the
+ * page into a folio that is not lazyfree, quietly making memory the process
+ * offered up undroppable again.
+ */
+static void collapse_order_lazyfree_window(struct collapse_context *c,
+					   struct mem_ops *ops)
+{
+	size_t window = mthp_window_size();
+	void *p;
+
+	mthp_push_target_order();
+
+	p = ops->setup_area(1);
+	ops->fault(p, 0, hpage_pmd_size);
+	if (!window_not_collapsed(p, hpage_pmd_size))
+		ksft_exit_fail_msg("Unexpected large folio after fault\n");
+
+	/* Clean and lazyfree: do not touch this page again. */
+	if (madvise(p, page_size, MADV_FREE))
+		ksft_exit_fail_perror("MADV_FREE");
+
+	madvise(p, hpage_pmd_size, MADV_HUGEPAGE);
+	ksft_print_msg("Collapse the windows beside a MADV_FREE'd page...");
+	if (!khugepaged_wait_full_pass())
+		fail("Timeout");
+	else if (window_collapsed(p + window, hpage_pmd_size - window) &&
+		 window_not_collapsed(p, window) &&
+		 /* Left alone at every order, not just the target one */
+		 is_range_backed_by_folio_orders(p, page_size, 0,
+						 pagemap_fd, kpageflags_fd))
+		success("OK");
+	else
+		fail("Fail");
+
+	/* Everything but the freed page, whose contents may be gone. */
+	validate_memory(p, page_size, hpage_pmd_size);
+	ops->cleanup_area(p, hpage_pmd_size);
+	thp_pop_settings();
+	ksft_test_result_report(exit_status, "%s\n", __func__);
+}
+
 static void usage(void)
 {
 	fprintf(stderr, "\nUsage: ./khugepaged [OPTIONS] <test type> [dir]\n\n");
@@ -1976,6 +2019,7 @@ int main(int argc, char **argv)
 		TEST(collapse_order_sub_pmd_range, mthp_khugepaged_context, anon_ops);
 		TEST(collapse_order_sub_pmd_holes, mthp_khugepaged_context, anon_ops);
 		TEST(collapse_order_mlocked, mthp_khugepaged_context, anon_ops);
+		TEST(collapse_order_lazyfree_window, mthp_khugepaged_context, anon_ops);
 	}
 
 	TEST(collapse_full, madvise_context, anon_ops);
-- 
2.54.0

