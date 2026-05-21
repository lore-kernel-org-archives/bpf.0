Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E71316DEB1;
	Thu, 21 May 2026 04:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336487; cv=none; b=NblGh4IP0dpzG7fPpoSBkGMgk833xi6VGVLwwEZkFD8zgnbRhC0oatl5mORa1n04vT+iQPqLaz2RQfE0l2+aPZFlYsZH/3jp+LATpTBQQQNYgnGebnK2GWllR3+CS3642c0gdGhhQotSAgsKnscxJcRy1m9Dw7+zWOXYcaQc330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336487; c=relaxed/simple;
	bh=4Qtf6EBTo3/7R4UuFjxvXJiq5qX3B4t1CbTeoLv/Uaw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=u/5XY3LUxiLQ/vL/EIC93wWCzsTLHIZoxjVHGy/U8jwkJFj3PZp7H2jKuuCiGkdrii3c84xJ0HDucfwuRYOs6vp9IG451dRUEu6nMgaID3Z3yVdPsoIVPFy5lFag1kk8JZNK6DKeMDYRG2/4EJhfj+5Ob4MQDToVUvCG6koKlPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVhbB0wb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVhbB0wb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA881F000E9;
	Thu, 21 May 2026 04:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779336485;
	bh=9467rb5UldAV/76NIyYvwg6WpTACGzUB/S3ZgqWxM7o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MVhbB0wbPVXsKPKLrl+rmD6RNvD0OMRH/Q9Hjv7kBDsyRw90PNPwBhhxYsfBKrDf3
	 4RExS0oBVjnmy8VVGHd2XWvwVixsw8H7FRgUnMUZZAdzSmdVW6gaEwYnrflNgr8H8j
	 /GqFTK5kerjHQwWXHT8hMmUjepEIgg3QwUTzJhX9iZoQjumkvsOFSu5BOc7wymjud1
	 gC9E7zvv1Qbvfal2tXYg2/SRMrM7Nj9kFIhDdusOArBjIWatq/0snPd8LyV5Ch3Sdu
	 igCfIRNkpmH5mobo6evZxWqPAV22C5lhumKGBmniw+2og6rlAW9O/n0rTr2YkntNAe
	 9FQNahevf8vKQ==
Content-Type: multipart/mixed; boundary="===============8231454790596158807=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <73c5ca2cbb7038a163e134e348fc4de3d3d83612c5dbafa2db02d5f44dff5f94@mail.kernel.org>
In-Reply-To: <20260521032306.97118-9-kaitao.cheng@linux.dev>
References: <20260521032306.97118-9-kaitao.cheng@linux.dev>
Subject: Re: [PATCH bpf-next v11 8/8] selftests/bpf: Add test cases for bpf_list_del/add/is_first/is_last/empty
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,ast@kernel.org,corbet@lwn.net,martin.lau@linux.dev,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,skhan@linuxfoundation.org,memxor@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-doc@vger.kernel.org,vmalik@redhat.com,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 21 May 2026 04:08:05 +0000 (UTC)

--===============8231454790596158807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit 75130d2969168e50252cc473cfaa880a9795c0ef
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

    selftests/bpf: Add test cases for bpf_list_del/add/is_first/is_last/empty

    Extend refcounted_kptr with tests for bpf_list_add (including prev from
    bpf_list_front and bpf_refcount_acquire), bpf_list_del (including node
    from bpf_list_front, bpf_rbtree_remove and bpf_refcount_acquire),
    bpf_list_empty, bpf_list_is_first/last, and push_back on uninit head.

    To verify the validity of bpf_list_del/add, the test also expects the
    verifier to reject calls to bpf_list_del/add made without holding the
    spin_lock.

    Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>

The commit message mentions adding test cases for bpf_list_is_first,
bpf_list_is_last, and bpf_list_empty, but these test functions already
exist in the file and are not added by this patch. The existing tests
are list_empty_test, list_is_edge_test1, list_is_edge_test2, and
list_is_edge_test3.

This patch actually adds:
- list_del_test3 (new test for bpf_list_del with list_front return value)
- list_add_test1 (new test for bpf_list_add after prev node)
- list_add_test2 (new test for bpf_list_add with list_front as prev)
- list_push_back_uninit_head (new test for push_back on uninitialized head)
- list_del_without_lock_fail (negative test for del without lock)
- list_add_without_lock_fail (negative test for add without lock)

Should the commit message be adjusted to accurately reflect which tests
are being added?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26204125015
--===============8231454790596158807==--
