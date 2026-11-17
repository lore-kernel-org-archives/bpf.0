Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911672;
	b=WgiDFaLFq6FpVeQcuTAaCsEpd6B/Mc3Ejq1bEb6fp/B+5Ltm90HrJGdSCM+DlS6SE/6L
	 d0WojPjyxo2KX0/X6oGaTHq4Q//Yp4Zr6NHjsYslqdYCH0rQxyoDIMBde/YU82b75L72t
	 TUCE4rvAXDfDR7cEAiJBCXTv7WUZvzuVYEIwGo3ThwsVgCp6gzKG0HhLul47owPAieBUK
	 6yugcqgWAyP1BAnsTjUAQh6OCXALhdYl1BX7okoICY+/2pDoUPps25fd2kufrxuDR8W5c
	 AEBey89KPjk+gA00jAhO2TbmzkFjjNZ3VG2iBa1em1Woft/aGtoFsCIF/SnfZyXieLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911672;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s2vEz+Hai+9jIoumFla7IOU7lsf4NKNKOJJKy7MP+cA=;
	b=k/IMP0rkQ9odLivsMIdfFTmX1aIs8mygboJOa8k5mnSag+OMROIPA3lSCfsLakHUoemI
	 6bAwvIynHyUcToPFgRzpbVfQI4jQ6woB9YrdvxeirEdqomElJkce3YvPo8ZdzE8oJwzem
	 ogwfgUAndjOujxGcwEP8kPKS+z1IRa1NjYmsNr7nya0U//GCBGsEuYR+tttK+E1KAsiSt
	 2a0sUQlvilaJgIgnzSHsncqGMEZfFtIs47sX1JzVbQouWymBvAvJM08fN59DyCDe73f9n
	 ixqUnTv1LAtS81KUn1BfuRzQtRMYW7FI3+Cb0EN/FEkKvr14kMF4fFy/w+j6+a/v04Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=DvBMVMrK;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF6606A336;
	Tue, 17 Nov 2026 10:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FCF6606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=DvBMVMrK
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW7-001QXA-7z; Tue, 17 Nov 2026 11:34:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=s2vEz+Hai+9jIoumFla7IOU7lsf4NKNKOJJKy7MP+cA=; b=DvBMVM
	rKqg1mZSTLj5e97sQcA2LGWG483TIvywRQmQQW4Lo/OePJW2HqpkH/2Lrl4IHCH7VeF0tQRKUaWKk
	VSnJR2MX7+y6PO+bMpqWnQuyUBzd0L5Ocoww8Bjgmo3mWqK7pLDRdkdNivR5PBcpem7Xt8WpncKPz
	tiqOoXzoDckmNGnlvMeMmeMQ+6ArbMJKCZW2po9qeCsT74e5iMqAAxsMz/Gm8RcUIkkSDMahWPECU
	1f3psveRYUw4L3w4fjlfDCWW8XyyVBvQTTwqfOyE5uGsZd4ct98EpE8hODRpA8uDKGAo9kHtUl9ZC
	poIeBV194olRwZSYVurfqtSfvOTQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW1-0002f1-N0; Tue, 17 Nov 2026 11:34:17 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xTGVj-005qHU-Af;
	Tue, 17 Nov 2026 11:33:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Petr Mladek <pmladek@suse.com>,
	Kees Cook <kees@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Samuel Wu <wusamuel@google.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 next 00/13] kallsyms: optimise symbol search by name
Date: Tue, 17 Nov 2026 10:33:39 +0000
Message-Id: <20261117103352.1244657-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
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

These patches speed up the lookup of symbol names by a factor of about 18
while both reducing the size of the compressed data by 9.5% (for my kernel)
and speeding up the compression code itself.
As well as improving the normal symbol lookup, looking up symbols that occur
a lot of times is also massively improved.

The technical content of these patches is the same as v2 except for an
additional compression optimisation in the final patch.
However rebasing onto 7.4-rc1 took some effort due to changes to
sripts/kallsyms.c.

v4 is pretty much the same as v3. It contains a couple of fixes from sashiko
and bot+bpf+ci that fix the compression output for BE on BE and for kernels
over 1GB and a few less important minor changes.
The biggest change is the addition of some extra consistency tests at the
end of the compression code.
The kernel code is really unchanged since v2.

Patch 1 is a stack buffer overrun - but in a program run during the build
    so is isn't that improtant.
Patch 2 improves the error reporting added for 7.4-rc1 and adds some timestamp
    output to time the different parts of the code.
Patch 3 obtains the target endianness from the elf file.
    Being run-time doesn't make any significant difference.
    (v2 extracted it from the kernel makefile.)
Patch 4 is, in some sense, a conditional revert of 83da9f3197e5 (output binary
    data speed output and kallsyms assembly).
    While the binary output does speed things up it makes debugging impossible.
    Change it to be a command line option.
    - Output the token table first and always in text - it is small.
    - Use a fixed format and fwrite() for the symbol values avoid printf.
      Reduces the time to output the symbol table from 5.8ms to 2.1ms
      (on my system, with my kernel, today).
    - The marker array is now written to bin.out in host order.
    Contains some of the changes from patch 14, but the size of the out.S
    file matters less.
Patch 5 (formally #2) is a fix to the selftest.
Patch 6 (formally #3) is a big update to the selftest output to make
    it less affected by interrupts (etc) and visually more obvious.
    Includes a very long symbol to check their handling.
The old patch 4 (error reporting) is merged elsewhere.
Patch 7 (formally #5) is from Jim Cromie and optimises the name compare.
    I think this is the final version of his patch, but any one will do.
    I've deleted a duplicate paragraph from the commit message.
    The following patches are built on top of it.
Patches 8 (merged #6 and #7) improve the search by name code.
    Indexing the list of names (not the values) speeds it up ~12 times.
    Marking duplicate symbols improves things as well, especially for
    symbols that appear 1000s of times.
Patches 9 (merged #8 and #9) make the 'marker density' a kernel build option
    and changes the default from 1:256 to 1:64 (one bit for two symbols).
    This change gives a 33% improvement on top of that from patch 8.
The old patch 10 is dropped.
Patch 10 (technically the same as 11, but rewritten) avoids the recursive
    expansion of compressed data. It speeds up the compression phase
    by about 17ms in 100ms.
Patch 11 (formally #12) speeds up the compression code by about 35ms
    in 100ms, it will be more for kernels with a lot of long symbol names.
Patch 12 (formally #13) reuses unused compression tokens to improve
    the compression ratio.
    (Patch 11 means they don't have to be kept to expand tokens.)
The old patch 14 is dropped, some parts went into patch 3.
Patch 13 (formally #15) improves the compression ratio by splitting little
    used tokens so that they can be used for more common token pairs.
    For v3 this includes tokens for three single characters as well
    as those where both the original tokens are still valid.
    This improves the compression ratio (for the test kernel) from 53.35%
    to 50.05%, so a 6% reduction in the datasize.

Some test output (TL;DR):

Timestamps from scrpts/kallsyms (typical values - they vary between runs):
Initial (7.4-rc1 with part of patch 4 applied):
kallsyms: stamp read elf 29.6 ms
kallsyms: stamp shrink table 0.1 ms
kallsyms: stamp sort symbols 2.2 ms
kallsyms: stamp build initial token table 10.9 ms
kallsyms: stamp insert real symbols in table 1.9 ms
kallsyms: stamp optimize result 109.5 ms
kallsyms: stamp write compressed names 11.3 ms
kallsyms: stamp write token table 0.0 ms
kallsyms: stamp write symbol values 5.8 ms
kallsyms: stamp sort by name 18.8 ms
kallsyms: stamp write name index 1.7 ms

Patch 4 (make binary data optional) changes:
kallsyms: stamp write compressed names 12.6 ms   +1.5ms
kallsyms: stamp write symbol values 2.1 ms       -3.8ms
The +1.5 comes from logic changes, the -3.8 by using fwrite() not printf().
(The all-text output is 50+ms slower overall.)

Patch 10 (fully expand tokens) changes:
kallsyms: stamp optimize result 98.2 ms           -15ms
kallsyms: stamp write compressed names 10.1 ms     -2ms
The changes from removing the number of short memcpy() and (probably)
changing the argument to compress_symbols() from 'char *' to int.
(In fact replacing memcpy() by a byte copy loop saves ~1ms.)

Patch 11 (Optimise compress symbols) is the big one:
kallsyms: stamp optimize result 64.5 ms           -34ms
In effect that reduces the compression from O(n^2) to O(n) in the
length of the symbol.

Patches 12 and 13 find more things to compress and make
it ~13ms slower.

One obvious change that would improve things would be to throw some
(more) extra memory at the symbol table and keep the original symbol
name. That would remove all the calls to expand_symbol() and make
the loop that outputs the compressed symbols trivial.
Potentially it would let the 'sort by name' be done be a separate thread.
I didn't look at why 'read elf' takes ~30ms, nor have I timed the
old code from 7.3.

kallsyms_selftest output (run in a userspace wrapper).
(Unchanged from v2, but the kernel code changes are minimal.)
The results are comparable to each other, but the in-kernel results
seem to be faster (possibly due to optimisation choices for functions
like memcpy().

Performance changes
The average value is a much better indication of speed than the
fastest (usually the middle of the table).
The slow times are likely to be worse than the figures imply, the tests
take long enough that the cpu clock frequency is likely to increase.

The times go down from:
kallsyms_lookup_name() looked up 123312 symbols, average 3753 ns
	fastest 341 ns (bpf_get_netns_cookie_sock_ops_proto)
	slowest 78069 ns (__func__.0)

to:
kallsyms_lookup_name() looked up 123312 symbols, average 204 ns
	fastest 60 ns (_rs.0)
	slowest 802 ns (The_time_has_come_the_Walrus_said_To_talk_of_many_things_Of_sho)

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
(That 'slowest' time looks like a lie.)

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
kernel code unchanged.

Final version.
Improves the compression ratio again.
(the v3 version is slightly better - 50.05%)
 ---------------------------------------------------------
| nr_symbols | compressed size | original size | ratio(%) |
|---------------------------------------------------------|
|     123312 |       1505184   |      2969490  |  50.68   |
 ---------------------------------------------------------
kernel code unchanged again.


David Laight (12):
  scripts/kallsyms: Avoid overrunning on-stack buffer
  scripts/kallsyms: Improve error reporting
  scripts/elf-parse: add elf_map_big_endian() helper
  scripts/kallsyms: make use of binary data output optional
  kallsyms: Fix selftest startup delay
  kallsyms: Improve selftest test_perf_kallsyms_lookup_name() output
  kallsyms: Optimise symbol name search
  kallsyms: Add a kernel parameter to change the kallsyms_markers[]
    density
  scripts/kallsyms: Keep full expansion of tokens
  scripts/kallsyms: Optimise compress_symbols()
  scripts/kallsyms: Reuse tokens that have no references
  scripts/kallsyms: Reuse little-used compression tokens

Jim Cromie (1):
  kallsyms: Match compressed tokens on the fly during binary search

 init/Kconfig               |   19 +
 kernel/kallsyms.c          |  262 +++++----
 kernel/kallsyms_internal.h |    8 +-
 kernel/kallsyms_selftest.c |  173 ++++--
 scripts/elf-parse.c        |   13 +-
 scripts/elf-parse.h        |    5 +-
 scripts/kallsyms-sysmap.c  |    1 +
 scripts/kallsyms.c         | 1035 ++++++++++++++++++++++++++----------
 scripts/kallsyms.h         |    1 +
 scripts/link-vmlinux.sh    |   13 +-
 10 files changed, 1104 insertions(+), 426 deletions(-)

-- 
2.39.5

