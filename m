Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493936B932;
	Thu, 20 Aug 2026 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251591; cv=none; b=Br0ETQ6B8VPdWddTGJSioxcOrZgMverofWBN9qI4/dL5+dNX+XnFtQNktF8zPHCe+ajX81a7NGq0gvhx8fl/hEcJrPUL/8Nx0b9YL7huP7ZAhjlNCkLXTxQsgsdm8oFqDPNkko9rF3McGjiamIFD4LDDkzm/KMQMA02PrTJSdL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251591; c=relaxed/simple;
	bh=rfF3HLh2l8W7T6w0erShcbdZsEf4ErrdRCsI4Lsif1w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AeRCfT/tgVk3C9yiGm70mvtRE75d4KYzc5SMPZB/1x3yZNRDxMu4A8TYjkc1AjKs8uSM1wYWkH+t8izyYNhYmqECBJlAKqMQ+AmexMIeO2t1cznueVQSJMfn9+Yz+ZM8sb6oxOk/TN7gnoiGHu1SZD2mICrbasxiWNlin+/Slsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAqrH+sf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAqrH+sf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3E71F000E9;
	Thu, 20 Aug 2026 18:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787251590;
	bh=85CoGMrbgo6hpuya2eU3QKLizIuVfSQg58+cQG2CLAk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JAqrH+sf0DqL0p1N2TEKaYARAPejw5joRwhyaP31YIrViRI83bfkuVXG/XyviOsuY
	 ifMN4WkPTwm1lm1B6Ef1iQXzzhzMaoLHNO2Bs0ooPojeLauUyNVco7wTljtxDfUgIj
	 QXMAdAfUxqFaIrH5Xo38olKWvMctjmQQM5DjDJ11ky4QZ3pIf6//Wfl5WYQXgcbQoN
	 SWR7vlN1HSajaVWf6+gs6k4+xXy7I+JxCYy9sOcng4FbR5pTtNHhCB0/Ue9ADuOGL9
	 En+vNKQGWNY1VgV6RMDhv/kPcUxlDPnoEbsNRgccvZlSYCaIN7DezfDWMUSxtm7y60
	 cQVMv4ITgRuHQ==
Content-Type: multipart/mixed; boundary="===============4789690843552500985=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <79ef5a0c38f6db7bd25876486bed41d8fc79f8503f2f35479c9322fc6c9d4567@mail.kernel.org>
In-Reply-To: <20260820175154.708374-1-sean@mess.org>
References: <20260820175154.708374-1-sean@mess.org>
Subject: Re: [PATCH] selftests/bpf: convert lirc_mode2 to prog_tests and extend coverage
From: bot+bpf-ci@kernel.org
To: sean@mess.org,linux-kernel@vger.kernel.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: sean@mess.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 20 Aug 2026 18:46:29 +0000 (UTC)

--===============4789690843552500985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/lirc_mode2.c b/tools/testing/selftests/bpf/prog_tests/lirc_mode2.c
> new file mode 100644
> index 000000000000..17a38cd03845
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lirc_mode2.c

[ ... ]

> +/* Load rc-loopback and find the lirc and input chardevs it created. */
> +static bool find_loopback_devices(char *lirc_path, char *input_path,
> +				  size_t path_sz)
> +{
> +	glob_t gl = {};
> +	bool found = false;
> +
> +	/* Ignore failure, we check for the resulting devices below. */
> +	system("modprobe rc-loopback > /dev/null 2>&1");

A subsystem pattern flags this as potentially concerning: this hand-rolls
a fire-and-forget shell invocation when test_progs.h already provides
SYS_NOFAIL(fmt, ...) at test_progs.h:444, which handles both the ignored
return value and the redirect to /dev/null. The line would become just
SYS_NOFAIL("modprobe rc-loopback"). SYS_NOFAIL() is used 119 times across
prog_tests/ for exactly this pattern.

The subsystem guide flags tests that reimplement existing helpers instead
of using them, though in this case raw system() is also widespread in
prog_tests/ so the behaviour is identical either way. Worth considering
for consistency?

> +
> +	if (glob("/sys/class/rc/rc*", 0, NULL, &gl)) {
> +		fprintf(stderr, "No rc devices found, is CONFIG_RC_LOOPBACK enabled?\n");
> +		return false;
> +	}
> +
> +	for (size_t i = 0; i < gl.gl_pathc; i++) {
[ ... ]
> +		if (!strstr(uevent, "DRV_NAME=rc-loopback"))
> +			continue;
> +
> +		snprintf(pattern, sizeof(pattern), "%s/lirc*/uevent", rcdir);
> +		if (!find_devname(pattern, lirc_path, path_sz))
> +			continue;
> +
> +		snprintf(pattern, sizeof(pattern), "%s/input*/event*/uevent", rcdir);
> +		if (!find_devname(pattern, input_path, path_sz))
> +			continue;
> +
> +		found = true;
> +		break;
> +	}
> +
> +	globfree(&gl);
> +	return found;
> +}

A subsystem pattern flags this as potentially concerning: the only
diagnostic is attached to the wrong condition, so the common unconfigured
case skips with no explanation.

glob("/sys/class/rc/rc*") fails only when there is no rc device at all
(CONFIG_RC_CORE=n or no IR hardware), yet that's where the message names
CONFIG_RC_LOOPBACK. The actual CONFIG_RC_LOOPBACK=n case (rc devices
exist, but none has DRV_NAME=rc-loopback) and the CONFIG_LIRC=n case (no
lirc*/uevent under the loopback rc device) both fall through the loop and
reach the silent 'return found' with found=false.

test_lirc_mode2() then calls test__skip() with no message (test__skip()
takes no argument), so the run reports lirc_mode2:SKIP with nothing
telling the reader which prerequisite was missing.

> +
> +void test_lirc_mode2(void)
> +{
> +	char lirc_path[PATH_MAX], input_path[PATH_MAX];
> +	int lircfd = -1, inputfd = -1, progfd, progfd2 = -1;
> +	struct lirc_mode2 *skel = NULL, *skel2 = NULL;
[ ... ]
> +
> +	if (getuid() != 0) {
> +		test__skip();
> +		return;
> +	}
> +
> +	if (!find_loopback_devices(lirc_path, input_path, sizeof(lirc_path))) {
> +		test__skip();
> +		return;
> +	}

A subsystem pattern flags this as potentially concerning: both skip paths
call bare test__skip() with no accompanying message, so the two very
different reasons for skipping are indistinguishable in the test output.

The first skips because the test is not running as root; the second skips
because find_loopback_devices() could not find an rc-loopback lirc/input
device pair (which can mean CONFIG_RC_LOOPBACK is not built, or modprobe
rc-loopback failed, or the sysfs walk did not match). A user seeing
lirc_mode2:SKIP has no way to tell which precondition was missing.

That said, bare test__skip() with no message is the overwhelmingly
dominant idiom in this directory (126 call sites use it with no message),
and test__skip() accepts no message parameter, so there is no in-framework
way to attach a reason. By the 'compare to the neighbours' rule this would
normally be consistent with established practice.

> diff --git a/tools/testing/selftests/bpf/progs/lirc_mode2.c b/tools/testing/selftests/bpf/progs/lirc_mode2.c
> new file mode 100644
> index 000000000000..98137f3c5c03
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/lirc_mode2.c

[ ... ]

> +SEC("lirc_mode2")
> +int bpf_decoder(unsigned int *sample)
> +{
> +	if (LIRC_IS_PULSE(*sample)) {
> +		unsigned int duration = LIRC_VALUE(*sample);
> +
> +		/*
> +		 * Flag bits picked deliberately low: rc-loopback simulates
> +		 * a receiver overflow for any pulse over MS_TO_US(50) (see
> +		 * loop_tx_ir() in rc-loopback.c), which would silently
> +		 * swallow the sample before it ever reaches this decoder.
> +		 */
> +		if (duration & 0x8000)
> +			bpf_rc_keydown(sample, 0x40, duration & 0x3fff, 0);
> +		if (duration & 0x4000)
> +			bpf_rc_pointer_rel(sample, (duration >> 7) & 0x7f,
> +					   duration & 0x7f);
> +	}
> +
> +	return 0;
> +}

Does the comment match what the code does? Looking at the deleted
progs/test_lirc_mode2_kern.c, the old decoder used flag bits 0x1000/0x2000
with masks 0xffff, >>8 & 0xff, and & 0xff. The new code uses 0x8000/0x4000
with masks 0x3fff, >>7 & 0x7f, and & 0x7f.

The comment claims the flag bits were "picked deliberately low" to stay
under rc-loopback's MS_TO_US(50) overflow threshold, but the bits were
moved UP: the largest encodable sample went from 0x3FFF (16383 us, ample
margin under the 50000 us threshold) to 0xBFFF (49151 us, 849 us of
margin), and with both flags set, 0xFFFF (65535 us) exceeds the threshold
and would be discarded by ir_raw_event_overflow() rather than decoded.

The two committed test vectors (0x8ead and 0x4081) are both safe, so the
test passes today. The concern is future-facing: the comment actively
misleads anyone adding a third vector into believing high-bit values are
the safe choice, when the new layout leaves only 849 us of headroom and
any value with both flag bits set is silently swallowed by the loopback
overflow simulation.

The new bit layout is genuinely cleaner than the old one (with flags at
0x1000/0x2000 and rel_x extracted as (duration >> 8) & 0xff, the 0x2000
flag bit landed inside rel_x, so flags and payload overlapped). Moving
flags to the top two bits and shrinking the payload to 14 bits removes
that overlap. Could the comment be updated to match what the code actually
does, and perhaps mention the 50 ms ceiling on encodable samples?

Also, the commit message enumerates five coverage additions but does not
mention the format change at all.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32401351183
--===============4789690843552500985==--
