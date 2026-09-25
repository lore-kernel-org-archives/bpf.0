Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4AB4D794C
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368785; cv=none; b=L1EupwykD//UScArYo3A7KeVRUF6/7ZJ59BFec8Igs93YDaYSBxjtN4Bx18xuQvk6Z1NWzBhg3eY5AdEvYF7lan/EgFc4Jy5jb0SDTkwQ3FyGAfKuy0Ej8x9xrjwcQAn28Q633ip7Q/09gLMUUzUx58ty9NxyeoqpcCubgJUPmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368785; c=relaxed/simple;
	bh=pKXIpeFaErgn2NEiF8MiFKNoe1Q1PfuIcKipDX3mXkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwsvH5FnUA9tJSSDYHl4tNoYXmDYkAY1hD5sY6Dr4OE70nvId021F//b7/5BucfqUaPATOJYx8DcMNJblLbRdwNOOP37nxD57Xm6azSkxWXtayCtyVDjBbhV5C1IwS2NLRawqKmsIeQdPwKlz8/cHl3PirUBk6xfnSMRcCMGpoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=czCl4AzL; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="czCl4AzL"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ee1f9bso6689555ad.3
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 13:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790368783; x=1790973583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9QIFuwjRucPgSyZcWSBOkA7RJtb3qls5D8mqQ6di/is=;
        b=czCl4AzL+iuOJtQ9wxh/sHkg6gAgGo6a5b90o4/pbfia2V9AgWjqj/6ksUjjxpKkgs
         Sy6ImPNJzM4vz/izIZ3cdJPl1SuxyNYj1o/+X09ASzhOnSdgiaIJG3Qz0EZu2xWpQC2Y
         K5kHx7Jr+A7EskOLqPxMQoew4tTncNCAhlY+eVSZiXFpkbKPCGv1geKcxzarQRoD95cz
         y5HdUw6axtHVnBP4VmJy+FoLihyLu2Ym4i2DmE+VF4xarJFs70xnyMZrlUnb85XyJ5fL
         79zGcA+4YjQYyY0uXbFQvuanh75obi9GXvJE9/5B2OXKT/XH1t9PuOR41klTrKTFUYc/
         ZUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790368783; x=1790973583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9QIFuwjRucPgSyZcWSBOkA7RJtb3qls5D8mqQ6di/is=;
        b=uWbdYZzYvwuzGzrks3os6jl925Md1kPyvoJf8Ukfhx2sErrfxMKfHtKGL2mUMSvJ6u
         EsXOEPB4ac6jv3XQr7/rEJ1Q3p5oTBte3WSK7/Tl7tmu7dht1jytV9cbIlVatrt4Fqm7
         DYZVJKZgsdzOeNfUKmcjDlwew1GqIXlCp5sEctENqlYQwPbqWCMr2t+YhcYlD9Yu/aOg
         KdeLJbW4b2tEV28GyhiyyIJJP7D8DV1daIeSeKgchHjLeZLRLSmSi55F2JjKPs3iT6A6
         5KnNghzVeYT3zJD9822FaZrxWhib4O1kKJ2HACpYW1SeMzIQWbPrPWZuiwJxaNhsVKEm
         or2g==
X-Gm-Message-State: AFuF++mjxBctRAz/+YYCi034p97fktrTmBm++3nOyeQLGvtG1HDFrNI0
	F7gwzXX82HPCBlU1VmQIQqdURv8SCVCWv3CGmteizwhg5/seG7FuviQODuWfn3L0EmSAyB4xhty
	fthcjg7E=
X-Gm-Gg: AYBFou0FCOD7YmHhRIhcYBtTt+IN6BM3GfItIeaPhfZAkhNfQcLpMcq86iqWpCQqRMY
	Mc+HSr/Z1XvMy7o6+ES+GJr/7azarSPZfHj/Ydg1f32Xq1Cgn/hIUX0sK1WIAwafaVVtS6fKngt
	ysACCVS5IbUZjdfGBL+BBGEn5SIXyA52545Kvkt1Z/3syE6Sa96w9wwUU86rPzpEsh5XPpcFG0u
	vvrQbWAKGt3M+7LrwbZhuuF8YJbo67rEHBbh8zwo1kMbtfS++l2Uavkxje8XubCmY2yOonB1BAB
	gmKMlAVscbm09oB1iGdEjOJeRiPlz7EZEIpvJxe3rhF3yM3/8hJKt0AvNmTS7uNcfR9BA6ehzGv
	2mA4JZPUTi7ohxa7FCWvvk+8LIEURAml8sW6QhwWBaNYN1wkyXknZRc5s6IfS2jo/eXfk0m9uFB
	usX9nwP7bSEJGHgXPEoV0x85vDAZXixkWsJBsk6QJ0bDLTQMywWas0tnogzDx9UQjkOchemD6ea
	Bt6iBqVK+e3UJb/+QumE62wqBgs1Z37wzUvV8Cteg==
X-Received: by 2002:a17:902:f705:b0:2df:8aea:7d99 with SMTP id d9443c01a7336-2df8aea88aemr39511945ad.59.1790368782869;
        Fri, 25 Sep 2026 13:39:42 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9481e17sm5955125a91.8.2026.09.25.13.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:39:42 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v3 0/7] Make sleepable arena paths use sleepable alloc_pages
Date: Fri, 25 Sep 2026 20:39:32 +0000
Message-ID: <20260925203939.4105-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena_alloc_pages() call takes a sleepable argument based on whether
its caller is a sleepable BPF function. This flag, along with the context
the kfunc is called in, decides whether the call will try to fulfill the
allocation using the regular or the _nolock variant of the alloc_pages
API, by means of bpf_map_alloc_pages().

However, the arena_alloc_pages() call currently only makes allocations
inside an IRQ-disabled critical section. This forces all allocations to
use the _nolock() API, which may eagerly fail where the regular variant
would eventually succeed. There have been reports of this happening for
sched-ext schedulers.

Restructure arena_alloc_pages() to use the _nolock() page allocation API
only when necessary. This requires moving allocations outside of the 
spinlock critical section for sleepable calls, which in turn requires
slightly different logic in the allocation path. Make a separate
sleepable code path that implements this logic within
arena_alloc_pages().

Also fix kfunc specialization to not unnecessarily force the nonsleepable version
of bpf_arena_alloc_pages() for call sites that do not need it. This requires
making specialization per-call site instead of overwriting the descriptor
during fixups. 

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

v1 -> v2 (https://lore.kernel.org/bpf/20260824082530.47553-1-emil@etsalapatis.com/)

- Keep the sleepable and non-sleepable allocation paths within
  arena_alloc_pages (Alexei)
- Incorporate bot feedback on selftests (bot-ci)

v2 -> v3 (https://lore.kernel.org/bpf/20260923191125.5311-1-emil@etsalapatis.com/)

- Remove the intermediate page array allocation in bpf_arena_alloc_pages() and
  use the pcp_llist pointer instead (Alexei)
- Fix function specialization to only specialize to the nonsleepable version
  when necessary


Emil Tsalapatis (7):
  bpf: Use an llist for page allocations
  bpf: Add sleepable argument to bpf_alloc_pages()
  bpf: Add sleepable arena page allocation path
  selftests/bpf: Test large allocations for both sleepable/nonsleepable
    arena users
  bpf: Support call-site kfunc specialization for near calls
  bpf: Support call-site kfunc specialization for far calls
  selftests/bpf: Test per-call site function specialization

 include/linux/bpf.h                           |  10 +-
 include/linux/bpf_verifier.h                  |  15 +-
 kernel/bpf/arena.c                            | 186 +++++++++++-------
 kernel/bpf/fixups.c                           |  18 +-
 kernel/bpf/syscall.c                          |  43 ++--
 kernel/bpf/verifier.c                         |  82 +++++++-
 .../selftests/bpf/prog_tests/file_reader.c    |  15 ++
 .../testing/selftests/bpf/progs/file_reader.c | 129 ++++++++++++
 .../bpf/progs/verifier_arena_large.c          |  64 ++++--
 9 files changed, 434 insertions(+), 128 deletions(-)

-- 
2.52.0

