Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268ED3E468
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521996; cv=none; b=Y2B/R7i1StWUysLNXTCKhTuxVdfZBKjblDP+RxpoZpNQ7tOiEQSc0Y5BMAtIN66Rxumei8bQ1a6UP9YPMOfyPw1YoJ/ljx33IRPAKifWQTNWIVHWDDUvuWDl5xwYOb1cMi+LNWvrKWkyqqsQkxzAY0Ry+PgTNAsSKf5Sau4dEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521996; c=relaxed/simple;
	bh=gOFWg+Soet3zf2ymGyBtCsHiHIkvYKA7Xc3yBmWRh6U=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QlQPQRNl6jSiccDfZy8JN8A3wS4VUrW5vGE3GIbk8wdne1FOGIZtMPJVfKUbxvoMVM0JUwkrKh+dehQpRBR27ljvbY9dmmkh4JFXEEqYJbPl5Yld8M7iDNPbHmnDztOdpy7g0VzpQZ+Nk8SE7KfeBag1/H3dx4DKgCpnFvv0nmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXuRGs1E; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXuRGs1E"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60a0579a931so23325907b3.0
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710521994; x=1711126794; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iDUmoSzGBEtNENL+i+Aq7ymY6JdBWz9oe3dql8bgoU=;
        b=NXuRGs1E7YVo4iD2tAyg49J67TuoOu4XkZflEINBmKJKKsH9tJzZn6vtf0uS2+oTav
         w7KvPwBF7PB0DEVifzj5nUw6uGVHIskyWpV9RC7RLAxcz14/f8/yVfdIVHtz5usom2dr
         9g06mik20l01n7mYV89gih4z6VE/m5FmSA8fXgLHnGk01OKbN5dVzkdlTnqZ3jMKoqSs
         CDX2YKuHJfeUvBMhwh6d6OxJdBy09kUCuFC+Yl2OcoBxONln6JuNRE84nfElU5oJqgRD
         o+3b8UyWeFjsUzfJwnSnm0FNkFA3fQVlVTkL0l3thURjxS2PvcsIeDjJuNfhopyBc+IP
         qtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710521994; x=1711126794;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7iDUmoSzGBEtNENL+i+Aq7ymY6JdBWz9oe3dql8bgoU=;
        b=CuWYxe8hA/IsZZn2NReU12s1XzxcbnOkaXPwGuP/W6GeVooB65vdUZ2qLVmMqCg5q3
         JrxCZU250DnY/Anj7sbX4rpwVWT6aynSI0FFE6L726j5H9iAkCZLCFzkU1l5uw0C9XB3
         R9/M2gCAzSdAOT+dV9R2td+n0K9tSGZ+78W/W7K8DQS7zHhSsPUIUFpTepsL7qpugCGA
         75B/t1TOSKOWCJBxpzLuZDUYSlo3nmqSkwZu0WaAEweQ0Lwzq3slSotxIM+kcZwA0QbE
         wgCgcva2+6uGR7toB+vH4RZN82dI20hAa2asjusV4j7p9fPzjklU65HkeGLGuEM92+2R
         lQAg==
X-Gm-Message-State: AOJu0Ywafpajqmq49d/Fd7WYbVHC7TGTmMGD5aA+pcAr/BQqK9HOEtE2
	33oCLIVsMazwAdImK9DjCZH8/4d1sn5JHyCxgL9LGjU+VgBBYETXt7yaqw27
X-Google-Smtp-Source: AGHT+IHoEi1aY5Q3ZbbNoQLgquna15ItH6VIKbdt1FfqSlkag0+qOQdiMSe91hMS1n33Ee70B7BWCg==
X-Received: by 2002:a25:688b:0:b0:dcf:c6d2:6c5f with SMTP id d133-20020a25688b000000b00dcfc6d26c5fmr2610291ybc.26.1710521994021;
        Fri, 15 Mar 2024 09:59:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:6c5d:5b71:895e:beb6? ([2600:1700:6cf8:1240:6c5d:5b71:895e:beb6])
        by smtp.gmail.com with ESMTPSA id 3-20020a251903000000b00dc6a0898efasm793114ybz.15.2024.03.15.09.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 09:59:53 -0700 (PDT)
Message-ID: <c9923c1d-971d-4022-8dc8-1364e929d34c@gmail.com>
Date: Fri, 15 Mar 2024 09:59:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Josh Poimboeuf <jpoimboe@kernel.org>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
Subject: Crash caused by 778666df60f0 ("s390: compile relocatable kernel
 without -fPIE")
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Josh, Sumath, and Heiko,

Recently, all patches submitted to bpf have been failing the selftest
"dummy_st_ops/dummy_init_ptr_arg" on the s390x platform. Upon
investigation, it was determined that a specific patch, 778666df60f0
("s390: compile relocatable kernel without -fPIE"), is causing the 
problem. It is the first bad after bisecting. Please take a look.
Thank you!

You can reproduce it by running the command

     ./test_progs -a dummy_st_ops/dummy_init_ptr_arg

in the tools/testing/selftests/bpf directory in the Linux source tree.
This command causes a kernel crash with the following messages. It
appears to be related to attaching a trace program at the fentry of a
struct_ops operator. The same operator works fine without the trace
program. For more details about the test case, please check
dummy_st_ops.c in tools/testing/selftests/bpf/prog_tests/.

illegal operation: 0001 ilc:1 [#1] SMP
Modules linked in:
CPU: 0 PID: 82 Comm: test_progs Tainted: G           OE 
6.8.0-rc3-g778666df60f0 #34
Hardware name: QEMU 3906 QEMU (KVM/Linux)
Krnl PSW : 0704d00180000000 0000000000000002 (0x2)
            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
Krnl GPRS: 000003ff800a4956 0000000000000000 0000038000a73d20 
0000000082a08b58
            0000000000000000 000000007083ede2 0000000000000000 
0000000000000001
            00000000009d580e 000000008286bc00 0000037f000000d8 
000003ff800b2000
            0000000081a43c00 00000000011bfe20 000003ff800b208e 
0000038000a73c68
Krnl Code:#0000000000000000: 0000               illegal
           >0000000000000002: 0000               illegal
            0000000000000004: 0000               illegal
            0000000000000006: 0000               illegal
            0000000000000008: 0000               illegal
            000000000000000a: 0000               illegal
            000000000000000c: 0000               illegal
            000000000000000e: 0000               illegal
Call Trace:
  [<0000000000000002>] 0x2
  [<00000000009d5cde>] bpf_struct_ops_test_run+0x156/0x250
  [<000000000033145a>] __sys_bpf+0xa1a/0xd00
  [<00000000003319dc>] __s390x_sys_bpf+0x44/0x50
  [<0000000000c4382c>] __do_syscall+0x244/0x300
  [<0000000000c59a40>] system_call+0x70/0x98
INFO: lockdep is turned off.
Last Breaking-Event-Address:
  [<000003ff800a49ac>] bpf_prog_83ebf4e90b071f2b_test_1+0x5c/0x70
Kernel panic - not syncing: Fatal exception: panic_on_oops


[1] 
https://github.com/kernel-patches/bpf/actions/runs/8297891630/job/22710267571
