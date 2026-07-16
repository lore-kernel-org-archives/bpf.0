Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D82EEE82
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236200; cv=none; b=nFycKACrOjVj0+zP7JvQyA/XZM6y7miJoUb3RsBx6j8hARdTqOth1Yyp2LPZzCUofJxfgW4wkJg6aE2VIGgFaoPJ5ZtNKEvydbxgHBbVaNjOvb0uYl+/rLlyO3pBoQH29786A+VmrHkSJF/2SJ6Z5usbMN/1bCHcBq2jbADXidk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236200; c=relaxed/simple;
	bh=Wrg2Rv4NaBpzTpPQCcNqA0QYIaD0fvsmo8kjBAUbyQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efv5S/0aZx+89nZa9jN5YbZUN/M/VfErUfUwLx/mKO1Ah9NrkZ7aWau6fZCmMA9t0m7WgJrfOmj87G+Vl3pymyR61YgiMDpscouGafCxuDrpTJZmHDVqs8gqjKsTkwQ2oq9H46DvrEDsV0rgjYjygd/ku8NSpm8EKjL1sXUEIh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=neeiSpMf; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="neeiSpMf"
Message-ID: <f3a5c7dc-6731-4a3e-b8bd-909c0fff4520@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784236196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khS4w+amc72eU4eeH8Vqsd3aLRhCVcDe8GHHM5vei/M=;
	b=neeiSpMf/Qj6kZpXMwlAZDozbUlu5THPFbpbfknHm56QqRL3yuhbLvLCJdhHbgZF7DAXx4
	uAowl+I5VbJa/lMzDSP+oCAZ7oFqhDB3VR5MI68dUmweknEoJ0PVOZ0maJxAf7QjijbBIi
	2pyPpFVO37Rp2UWXvrbN6BbCRsx1TQg=
Date: Thu, 16 Jul 2026 14:09:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] selftests/bpf: Install bpftool where test_progs
 expects to find it
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
 <20260710-selftests-bpf_fixes-v1-1-aa24dfd6f4f9@suse.com>
 <DJXJWE3X286K.16LM4LUS201ZP@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DJXJWE3X286K.16LM4LUS201ZP@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/13/26 8:32 AM, Alexis Lothoré wrote:
> Hi,
> 
> On Sat Jul 11, 2026 at 12:09 AM CEST, Ricardo B. Marlière wrote:
>> bpftool_helpers.c looks for bpftool at "tools/sbin/bpftool" or
>> "../tools/sbin/bpftool" relative to the running test_progs binary, matching
>> the build directory layout where bpftool sits at
>> $(OUTPUT)/tools/sbin/bpftool.
>>
>> INSTALL_RULE installs bpftool through the generic TEST_GEN_PROGS_EXTENDED
>> mechanism, which flattens it straight into $(INSTALL_PATH) and loses the
>> tools/sbin/ prefix. After "make install", every flavor of test_progs,
>> including the default one, fails to locate bpftool, and bpftool_maps_access
>> and bpftool_metadata error out with "Failed to detect bpftool path", even
>> though bpftool itself built and installed fine.
>>
>> Explicitly install bpftool under tools/sbin/ in the installed tree
>> so its relative location matches what detect_bpftool_path() already
>> expects, restoring the pre-install layout instead of introducing a
>> new one.
>>
>> Fixes: f21fae577446 ("selftests/bpf: Add a few helpers for bpftool testing")
>> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> 
> I did not face the issue because I am running the selftests in-tree, and
> the CI seems to do the same, but for users using selftests after running
> `make install`, I guess the change makes sense.
> 
> That's not the first fix aiming to improve bpftool
> detection/installation (eg the BPFTOOL env variable, see [1]), so it
> makes me wonder if we shouldn't just make bpftool part of
> TRUNNER_EXTRA_FILES for all flavours of test_progs, similarly to other
> binaries needed during tests (eg: urandom_read), instead of just adding
> some bpftool-specific details in this generic install rule, and just
> make the test runners assume that the needed binary is in the same
> directory.

Alexis, using TRUNNER_EXTRA_FILES is a bit worse because that would
copy bpftool into every flavor subdir. I think just doing a single
rsync on install is fine.

> 
> Alexis
> 
> [1] https://lore.kernel.org/all/20260223191118.655185-2-ihor.solodrai@linux.dev/
> 
>> ---
>>  tools/testing/selftests/bpf/Makefile | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index b642ee489ea6..47911c9b4977 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -1055,6 +1055,8 @@ endif
>>  DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
>>  override define INSTALL_RULE
>>  	$(DEFAULT_INSTALL_RULE)
>> +	@mkdir -p $(INSTALL_PATH)/tools/sbin
>> +	@rsync -a $(if $(PERMISSIVE),--ignore-missing-args) $(TRUNNER_BPFTOOL) $(INSTALL_PATH)/tools/sbin/


It looks like we still have a redundant copy of bpftool because of:

selftests/bpf/Makefile:327

        TEST_GEN_PROGS_EXTENDED += $(TRUNNER_BPFTOOL)

selftets/lib.mk:153

        $(eval INSTALL_LIST = $(TEST_GEN_PROGS_EXTENDED)) $(INSTALL_SINGLE_RULE)

Ricardo, does it makes sense to remove it with your fix?

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 7260d672acf7..c776913bc32f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -324,8 +324,6 @@ TRUNNER_BPFTOOL := $(DEFAULT_BPFTOOL)
 USE_BOOTSTRAP := "bootstrap/"
 endif
 
-TEST_GEN_PROGS_EXTENDED += $(TRUNNER_BPFTOOL)
-
 $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
 
 TESTING_HELPERS        := $(OUTPUT)/testing_helpers.o

>>  	@for DIR in $(TEST_INST_SUBDIRS); do				  \
>>  		mkdir -p $(INSTALL_PATH)/$$DIR;				  \
>>  		rsync -a $(if $(PERMISSIVE),--ignore-missing-args)	  \
> 
> 
> 
> 

