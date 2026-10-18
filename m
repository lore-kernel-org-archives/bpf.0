Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958E635BDDB;
	Sun, 18 Oct 2026 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338779; cv=none; b=l8m1uMwcWVPQASK6xIpDX9KTgftaItrMqK/4O55GJ/aFzxXJoR8vtCUGtiZXkCkiCVI6uN3r0ekP2oQFG/IFoxfj1tKjJhRo28F9nfp+igi6W9g6PqTqpIQz5wCQ2eus7/qUjED1S4pbx+nZbF5jk3OUeKsJ3Vo0uGPNpzCiXLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338779; c=relaxed/simple;
	bh=bSY+Wg81R5doIrPXunpAxMdUOlcqaqggcKkKzyktlqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fikk3vizYloLSTbo2q51n9o6MolkpN/HpFsq+UdV8UGnKOfCUsnQZSk/Yyxk2uq9w4haHQm7NexPiB53+5LBkkP6Lj8CYIK5US4OVwrTL7O9UIwlH45Jg6yqXxTT//4AKP2bS+QF/BB0/39htL0TvArpvIvFk8BEpVkG+93/8z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=VRtGmRPq; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="VRtGmRPq"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITBj-000IYJ-Gb; Sun, 18 Oct 2026 17:52:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=Zo28feUDuI1/SUSfNI7MWlmWtcDRYT1SZvODl6HstRw=; b=VRtGmR
	Pqx9kofe1R0E3/bf5dSzWgSl7t2ZFLDpyBAnuMgHB8t+ibDrEB6+0FI4GG0WCWzWr7/2cvzWL0Y+l
	9JXdtjerVh4FeQbdK0UaLqm0vyXPxaJgosc0gjDXxkETTvu8RqSaoEllPqKu6WU0aRYUSUa/HYAJM
	iJ0OWTLRNluk/AlyLQl5HpRpL8ICl+Ls2sw61KYk1qWxm9PsJhjG+s8SkT+zMMWjF9H+eCoE/9+IF
	zYJTLDVA44Yuckg8Mnv3w/EkED6F0V3BWQlS0+BBSBc+2m6GChKZwqB6nusLVyXljn1Kau+1Obkw9
	N1nFwGiDacvnuh5ULu9FAB/6J12Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITBd-00009n-KH; Sun, 18 Oct 2026 17:52:37 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xITBW-004q3U-VE;
	Sun, 18 Oct 2026 17:52:31 +0200
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Kees Cook <kees@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 next 00/15] kallsyms: optimise symbol search by name
Date: Sun, 18 Oct 2026 16:51:51 +0100
Message-Id: <20261018155206.132411-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches speed up the lookup of symbol names by a factor of about 18
while both reducing the size of the compressed data by 9.5% (for my kernel)
and speeding up the compression code itself.
As well as improving the normal symbol lookup, looking up symbols that occur
a lot of times is also massively improved.

Patch 1 is a stack buffer overrun - but in a program run during the build
    so is isn't that improtant.
Patches 2 and 4 are minor fixes.
Patch 3 is a big update to the selftest output to make it less affected by
    interrupts (etc) and visually more obvious.
Patch 5 is from Jim Cromie and optimises the name compare.
    I think this is the final version of his patch, but any one will do.
    The following patches are built on top of it.
Patches 6 and 7 improve the search by name code.
Patches 8 and 9 make the 'marker density' a kernel build option and change
    the default from 1:256 to 1:64 (one bit for two symbols).
    This change gives a 33% improvement on top of that from patches 6 and 7.
Patches 10 and 11 are preparatory changes to scripts/kallsyms.c.
Patch 12 speeds up the compression code by about 50%, it will be a more
    for kernels with a lot of long symbol names.
    Reading and writing the files isn't quick, but is faster than the
    compression code.
Patch 13 reuses unused compression tokens to improve the compression ratio.
    (Patch 11 means they don't have to be kept to expand tokens.)
Patch 14 just shortens the output file.
    I didn't go as far as replacing all the printf("%u", x) with
    fputs(str[x], stdout) - but that is a lot faster.
Patch 15 improves the compression ratio by splitting little used tokens so that
    they can be used for more common token pairs.

Most of the testing was done with a rather hacked together userspace wrapper
that contains enough #defines to compile the kernel files as a user program.
The program and its Makefile could be commited somewhere - suggestions?

As well as my normal kernel (I've booted a kernel containing most of the changes)
I've run the tests on an x86-64 allyesconfig build, the timings are similar.
I've not run the selftests on the allyesconfig with the original code - I don't
want to think how long it would take!

Some test ouput...

kallsyms_selftest output (run in a userspace wrapper).
The results are comparable to each other, but the in-kernel results
seem to be faster (possibly due to optimisation choices for functions
like memcpy().

TL;DR
The average value is a much better indication of speed than the
fastest (usually the middle of the table).
The slow times are likely to be worse than the figures imply, the tests
take long enough that the cpu clock frequency is likely to increase.

Baseline (based  on 7.3.0-rc4):
 ---------------------------------------------------------
| nr_symbols | compressed size | original size | ratio(%) |
|---------------------------------------------------------|
|     123312 |       1584006   |      2969490  |  53.34   |
 ---------------------------------------------------------
kallsyms_on_each_symbol() traverse all: 7507638 ns
kallsyms_on_each_match_symbol() traverse all: 9418 ns
kallsyms_lookup_name() looked up 123312 symbols, average 3753 ns
	fastest 341 ns (bpf_get_netns_cookie_sock_ops_proto)
	slowest 78069 ns (__func__.0)
	Distribution, 1280ns per column, 8714 counts per *:
	|  *
	|  *
	|  *
	|  *
	|  **
	| ***
	| ***
	|************ ****************                 ***************

After 'Match compressed tokens on the fly during binary search'.
This doesn't make much difference (yet) because the linear scan dominates.
 ---------------------------------------------------------
| nr_symbols | compressed size | original size | ratio(%) |
|---------------------------------------------------------|
|     123312 |       1584006   |      2969490  |  53.34   |
 ---------------------------------------------------------
kallsyms_on_each_symbol() traverse all: 7521035 ns
kallsyms_on_each_match_symbol() traverse all: 7986 ns
kallsyms_lookup_name() looked up 123312 symbols, average 3661 ns
	fastest 411 ns (pciehp_poll_mode)
	slowest 76677 ns (__func__.0)
	Distribution, 1280ns per column, 8759 counts per *:
	|  *
	|  *
	|  *
	|  *
	|  *
	| ***
	| ***
	|******** *  *   **    **   **                            ***

After 'Optimise symbol name search'.
 ---------------------------------------------------------
| nr_symbols | compressed size | original size | ratio(%) |
|---------------------------------------------------------|
|     123312 |       1584006   |      2969490  |  53.34   |
 ---------------------------------------------------------
kallsyms_on_each_symbol() traverse all: 7547445 ns
kallsyms_on_each_match_symbol() traverse all: 1733 ns
kallsyms_lookup_name() looked up 123312 symbols, average 377 ns
	fastest 90 ns (pkcs1pad_create)
	slowest 4578 ns (io_register_clone_buffers)
	Distribution, 80ns per column, 3494 counts per *:
	|   ***
	|   ***
	|   ***
	|  *****
	|  *****
	|  *****
	|  ******
	| *******************           ***        *              *

After 'Optimise detection of duplicate symbol names'
marker density 256:
 ---------------------------------------------------------
| nr_symbols | compressed size | original size | ratio(%) |
|---------------------------------------------------------|
|     123312 |       1584006   |      2969490  |  53.34   |
 ---------------------------------------------------------
kallsyms_on_each_symbol() traverse all: 7620445 ns
kallsyms_on_each_match_symbol() traverse all: 2976 ns
kallsyms_lookup_name() looked up 123312 symbols, average 336 ns
	fastest 90 ns (shmem_unuse)
	slowest 2044 ns (The_time_has_come_the_Walrus_said_To_talk_of_many_things_Of_sho)
	Distribution, 40ns per column, 1912 counts per *:
	|      *****
	|     *******
	|    ********
	|    *********
	|    *********
	|    *********
	|   ***********
	|  ******************                               *

With the marker denstity reduced to 64
 ---------------------------------------------------------
| nr_symbols | compressed size | original size | ratio(%) |
|---------------------------------------------------------|
|     123312 |       1584006   |      2969490  |  53.34   |
 ---------------------------------------------------------
kallsyms_on_each_symbol() traverse all: 7654179 ns
kallsyms_on_each_match_symbol() traverse all: 2405 ns
kallsyms_lookup_name() looked up 123312 symbols, average 204 ns
	fastest 60 ns (_rs.0)
	slowest 802 ns (The_time_has_come_the_Walrus_said_To_talk_of_many_things_Of_sho)
	Distribution, 20ns per column, 2783 counts per *:
	|         **
	|        ****
	|        ****
	|        *****
	|       ******
	|       *******
	|      *********
	|   **********************               *

After 'Reuse tokens that have no references'.
Improves the compressions ratio slightly.
 ---------------------------------------------------------
| nr_symbols | compressed size | original size | ratio(%) |
|---------------------------------------------------------|
|     123312 |       1575323   |      2969490  |  53.05   |
 ---------------------------------------------------------
kallsyms_on_each_symbol() traverse all: 7652996 ns
kallsyms_on_each_match_symbol() traverse all: 2625 ns
kallsyms_lookup_name() looked up 123312 symbols, average 203 ns
	fastest 60 ns (_rs.0)
	slowest 831 ns (The_time_has_come_the_Walrus_said_To_talk_of_many_things_Of_sho)
	Distribution, 20ns per column, 2876 counts per *:
	|         **
	|        ****
	|        ****
	|        *****
	|       ******
	|       *******
	|      *********
	|   ********************   *     *        *


Final version.
Improves the compression ratio again.
 ---------------------------------------------------------
| nr_symbols | compressed size | original size | ratio(%) |
|---------------------------------------------------------|
|     123312 |       1505184   |      2969490  |  50.68   |
 ---------------------------------------------------------
kallsyms_on_each_symbol() traverse all: 7742950 ns
kallsyms_on_each_match_symbol() traverse all: 951 ns
kallsyms_lookup_name() looked up 123312 symbols, average 200 ns
	fastest 60 ns (_rs.0)
	slowest 662 ns (The_time_has_come_the_Walrus_said_To_talk_of_many_things_Of_sho)
	Distribution, 20ns per column, 2916 counts per *:
	|         **
	|        ****
	|        ****
	|        ****
	|       ******
	|       *******
	|      *********
	|   ******************  **    * * *


David Laight (14):
  kallsyms: scripts/kallsyms.c: Avoid overrunning on-stack buffer
  kallsyms: Fix selftest startup delay
  kallsyms: Improve selftest test_perf_kallsyms_lookup_name() output
  kallsyms: scripts/kallsyms: Check for output file write errors
  kallsyms: Optimise symbol name search
  kallsyms: Optimise detection of duplicate symbol names
  kallsyms: Support changing the density of the kallsyms_markers[] array
  kallsyms: Add a kernel parameter for the marker shift
  kallsyms: scripts/kallsyms: Rename some variables for clarity
  kallsyms: scripts/kallsyms: Keep full expansion of tokens
  kallsyms: scripts/kallsyms: Optimise compress_symbols()
  kallsyms: scripts/kallsyms: Reuse tokens that have no references
  kallsyms: scripts/kallsyms: Reduce the output file size
  kallsyms: scripts/kallsyms: Improve compression by about 2%

Jim Cromie (1):
  kallsyms: Match compressed tokens on the fly during binary search

 init/Kconfig               |  19 ++
 kernel/kallsyms.c          | 242 +++++++++------
 kernel/kallsyms_internal.h |   6 +-
 kernel/kallsyms_selftest.c | 169 ++++++++---
 scripts/Makefile           |   1 +
 scripts/kallsyms.c         | 586 ++++++++++++++++++++++++-------------
 scripts/link-vmlinux.sh    |   6 +
 7 files changed, 687 insertions(+), 342 deletions(-)

-- 
2.39.5

