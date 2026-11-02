Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636655;
	b=27K0uIgKBosyqANyOqdjOtoXyEPPDCaxQZBbvMR1A4eMyqTdbtJLY62VZ8YUiMeo3CQC
	 ix4xVpczbnRUsY8jNRwri3YMVcJ8HUj27v6onD4aFx4q++OrgueGOBFH/BZOP9V+qaZ2j
	 y+ZvgaFmn9zbFu3kvdh3LcRICCGAv7Nk56HmrdIaapKoSG4nLCYpK2isczWgFUZ0cNmNQ
	 DyUMfU6JZf3xl2Cgr+fVN/jo8KGcGpX+WI0IrtTxESBMoxIcBGBC4Y8to4H9moIBtgBzj
	 +av+hL+i8H9WtgFz3ROT35Z4kq433sFaCBh45UM/KuaJus1Z/8LNyCV4kLTxCcu9aQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type;
	bh=+kWAEYe9lv2joOurQeqZinEGPKNoqeTC8nO4PNwrr5g=;
	b=fAN24sm74HMa6xlRMTbJP+PkMv50D7JZj260S+d50QmL1jtS9ocnRQ7I1vQYNXCySRPV
	 +lsVoIUYaTXpkqEVHnWVcZBEaAyPo7nB7M+WataVAC4zI/BrCk5XDy2qsZZR+aXoqYiDL
	 yHaxwqrYUq/wMFAyzveG75TlICMwFdNfs32frpKO/AGpSITNG73MU15e4yNxQYC/o6q6e
	 wrhehjfszKtMfo05oznmuw3nfJdJj+JWYaXeSkztThWxcqWbeEaG8YCK+YoBuZASA8Ja3
	 pEVJ0UlPkor2wBO/foFefD5Qi3hU9xUcxRBysg5SZ1l9a2NY7QeQtvsETidRAj07KVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Q2/NjgWd";
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21D9608361D
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 16:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A21D9608361D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q2/NjgWd
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b1ce85287aso1143412c88.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 08:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793636654; x=1794241454; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+kWAEYe9lv2joOurQeqZinEGPKNoqeTC8nO4PNwrr5g=;
        b=Q2/NjgWdlD9XDuxjTwBJdSGHeUMH4vJNVwZ3pQurqPJgQzoRwghrRen6IdHP9wHEIj
         eMaL9CzWiZT09XIay2pWM32E6XKTT/X/GDXV6evq2CuqwWfUp8oXoM5VprBW25FVMvs2
         rNsizp3AjzcZnsCh5T9rHYnq8KxjwUAUm6gtswGrfRg5L4Qxb0gD2BmIGXtEaGRcGAxS
         s4NlbeOt6fPt/OaEqcnmVGCJr+M2RMoUaMjhSn3BeQLh/ThXaZ57RYa4QCnmMmPMXd/g
         S87K4aab4+ViH0p0mYK6UMKo6W7YQmT3vfr0OxRF+GH6wzqLMY8IwU3uqHPA+0mSGj2M
         FRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793636654; x=1794241454;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+kWAEYe9lv2joOurQeqZinEGPKNoqeTC8nO4PNwrr5g=;
        b=ucuyhE4X6OfdtZrP8G3iEQrjfwnOswZPfLMuXt3qQQ3wrho3pquuBU/rWXBdGQ5F/X
         zsxQR87BAYbKU+b3FT4yjAvRrqHoKrNE+P7OZT+QI06tZbTarZotr/FG8l7Wrdey0daA
         oBZjnLLdvBodZL9zDdkG6XfmAy6BQNgMvdntglNceR7U4LGycAH27lpa7fZhCKclt2N3
         AL5ih8Q6G2HQpkI2h3GejJEvv6Jlasq8oEQozrloPLYleWUAUpEoTNK7UkFBPH2mCnIS
         DHK//WL7FzHM0nRf4fXbE7eTLHvFWLq7pmoQXxAAT3pZGuNmv93I9obJnioVzBDnQtKb
         eYsg==
X-Forwarded-Encrypted: i=1; AKwUvBwsyNRVTtcLECHOgewSwAJZCqkz3KnYtdtMh6NT3AJrtVsvcfmAH5AHT+tTrqxHDXhzg68=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkzBYS6r/puOYcwFaKXD/jk0xjUKgHjCL4+WbPpMjIXf70RXS/
	OQp9w6QOr6K+6Px91vHPQ6lKKDNTm1KOav7EZ+ynF+VZlDSp69odAVBn
X-Gm-Gg: AYBFou0mXm+5S0rdgiqyG/8qdLr55JQCgAJh7obkAoyBQJ3KijAlv4iyX43mHJJ9u6M
	E2JR4rl3WalXhNWv9NO14xxSSJi07HKOjiCDEFsoR/BFCoCpLEK3vQFnmZQk4B0mIWxdxqdUaM0
	XS802lhDu5XpDCU8oz4tjt3HiW6gzaxTo9UnFq89EUwSJ6voQIOYFBx1BqNTPZNn4wQ1lPmitKu
	xJQc1nohm/Xj9j01h3ZyaNyhZ7JWZJPANL3wF53NjcQUjHSvZZu87joUIizavQNd+ccQavB7R47
	OQ2X1oSZzJ9II7NHbfLjiPpdybWAkZTHfH9V2M0OhOJUJSmfPt9IVGzkVAcJLyfGnZcLxTfQ+Vq
	YuIJ4w0H9VO+EU8CY8ogFJt8KmK0Brt5h4NWrPnL2MRj2N+xEcKnb75ThCtqttEzAhJN2648vEQ
	7YBBNeZ4qecGy4ikegI1FYJZFoQY0hPsWcixMjIx/mpkWCSRdlhlRW55wS4yzEegiyF9dg4/km5
	PLxGv5zajzfwFdosjLSlPBolJQlRI7vQaILoNwJsPfmzG1VVeO76BvZwL2o1uksIdWi/Oro96+f
	NYqsCVA4bRpHcrH4MoPu+x/c7Pe/MTp9/3Ki9Bd1Hf4aiAT6QYVoyVAlqLkKWVjU2kMPhjrpgOM
	pdHC/BmrMYA==
X-Received: by 2002:a05:7022:ec4:b0:14f:8d59:edcc with SMTP id a92af1059eb24-1ac5c369adfmr17454547c88.12.1793636652369;
        Mon, 02 Nov 2026 08:24:12 -0800 (PST)
Received: from 0001-report.eml ([117.28.251.181])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854d925sm60990010c88.7.2026.11.02.08.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:24:10 -0800 (PST)
From: Chengfeng Lin <lin2530632123@gmail.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: x86@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linus:master] [x86/bugs] a3af84b0fa:
 stress-ng.seccomp.ops_per_sec 95.7% regression
In-Reply-To: <4h7zrdfpu3ailx5ajkyqohmcfuxgrk3tn7i7n3dkp3ksy5xehk@xqg5j6pqzocv>
References: <202608191340.98574fe2-lkp@intel.com>
 <4h7zrdfpu3ailx5ajkyqohmcfuxgrk3tn7i7n3dkp3ksy5xehk@xqg5j6pqzocv>
Date: Mon, 02 Nov 2026 18:43:58 +0800
Message-ID: <179361623876.3.16264907931792312619.redis-ibpb-report@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2083262864964411293=="

--===============2083262864964411293==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Pawan, Dave and Daniel,

I found another workload affected by a3af84b0fa00 while running MMTests:
Redis ZPOPMIN throughput on v7.3 is about 13% lower than on v7.1.3.
Unlike the repeated filter loading discussed here, the slowdown remains
after the tasks that triggered the predictor flush (IBPB) have exited.
Can this cost be reduced while preserving the security protection?

The machine is an i7-12700KF with 32 GiB RAM. All runs used CPU microcode
0x3e, and I did not disable any security mitigations. The test uses
unmodified Redis 6.2.6 and MMTests' redis-benchmark-small recipe:

  redis-benchmark --csv -c 1 -r 50000 -n 100000 -P 256

There is one client, no CPU pinning, and all 20 logical CPUs are available.
After each boot, I ran the full MMTests recipe nine times. Each run kept
all 20 commands, including ZADD before ZPOPMIN, and the recipe's five
internal repetitions:

                           v7.1.3 first       v7.3      v7.1.3 return
  ZPOPMIN (requests/s)        999,366         871,397      1,000,947
  GET (requests/s)          3,548,521       3,551,132      3,547,933
  Complete test time (s)       61.396          61.704         61.301

ZPOPMIN is down 12.87% relative to the mean of the two v7.1.3 baselines.
Within each boot, its coefficient of variation is below 0.75%; the two
baselines differ by 0.16%.
GET is essentially unchanged (+0.08%). The complete test, including
startup and cleanup, takes 0.58% longer. The ZPOPMIN sequence drains the
set without refilling it, so its request rate includes empty results,
not just successful member removals.

Bisection identified a3af84b0fa00. To test the effect of a flush without
changing kernel code, I used its parent, 96cce16e26dd, where Redis was
still fast. On each CPU in turn, a short-lived helper enabled
indirect-branch protection for itself using:

  prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH,
        PR_SPEC_FORCE_DISABLE, 0L, 0L)

After all helpers exited, I started Redis from a controller whose
protection setting was unchanged. Redis did not inherit the helpers'
setting.

ZPOPMIN throughput fell by 11.06% and 11.69% on two separate boots.
After another reboot, I ran the same helpers without changing their
protection settings. Throughput returned to baseline (a 1.33% difference).
Separate diagnostic runs found no BPF JIT allocations or associated IBPB
calls during the Redis test. They did show more samples of mispredicted
returns in kernel code, as on the slow kernel.

The tested v7.3 already includes a9b1f19a6a67, which reduces how often
BPF code allocation triggers an IBPB. This result concerns the cost
after an IBPB, rather than repeatedly loading filters during the
benchmark. I have not determined why the return-prediction penalty
persists after the helpers exit.

The helper used in these tests is attached as ibpb-pulse.c. On a dedicated
test machine, build it before rebooting:

  cc -O2 -Wall -Wextra -o ibpb-pulse ibpb-pulse.c

Boot the parent kernel, 96cce16e26dd, then run as a non-root user:

  for cpu in $(seq 0 19); do ./ibpb-pulse "$cpu" protect || exit 1; done

Then run the Redis test above against a fresh, dedicated Redis instance.
For the control, reboot into the same kernel and replace protect with
sham. The separate boot avoids carrying over the effect of the protect run.
The helper is limited to CPUs 0-19 and checks the initial protection state.
I would be happy to test changes that preserve the security protection.

Thanks,
Chengfeng

--===============2083262864964411293==
Content-Type: text/x-csrc; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ibpb-pulse.c"
MIME-Version: 1.0

#define _GNU_SOURCE
#include <errno.h>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <unistd.h>

/* Opt IN to protection for this disposable process only. Never enable
 * speculation, touch an MSR, change a system setting or run a benchmark. */
int main(int argc, char **argv)
{
    char *end;
    cpu_set_t mask, actual;
    if (argc != 3 || (strcmp(argv[2], "sham") && strcmp(argv[2], "protect")) ||
        getuid() == 0)
        return 2;
    errno = 0;
    long cpu = strtol(argv[1], &end, 10);
    if (errno || *end || cpu < 0 || cpu >= 20)
        return 3;
    CPU_ZERO(&mask);
    CPU_SET(cpu, &mask);
    if (sched_setaffinity(0, sizeof(mask), &mask) ||
        sched_getaffinity(0, sizeof(actual), &actual) ||
        CPU_COUNT(&actual) != 1 || !CPU_ISSET(cpu, &actual) || sched_getcpu() != cpu)
        return 4;
    int before = prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, 0L, 0L, 0L);
    if (before != (PR_SPEC_PRCTL | PR_SPEC_ENABLE)) {
        fprintf(stderr, "unexpected initial speculation mask %d errno %d\n", before, errno);
        return 5;
    }
    int protect = !strcmp(argv[2], "protect");
    if (protect && prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH,
                         PR_SPEC_FORCE_DISABLE, 0L, 0L)) {
        perror("protection opt-in");
        return 6;
    }
    int after = prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, 0L, 0L, 0L);
    if (after != (protect ? (int)(PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE) : before) ||
        sched_getcpu() != cpu)
        return 7;
    printf("{\"cpu\":%ld,\"pid\":%ld,\"uid\":%ld,\"mode\":\"%s\","
           "\"before\":%d,\"after\":%d}\n",
           cpu, (long)getpid(), (long)getuid(), argv[2], before, after);
    return 0;
}

--===============2083262864964411293==--
