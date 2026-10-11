Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7E39CCFF;
	Sun, 11 Oct 2026 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791717437; cv=none; b=dzBrGX1+7pobEMwpu9iTJ3Q5vs1CGiTVa/bQDN6xuJJyMjzDBBP4QVY6dnif1WEX988K2vpUn1XK0YM4Z60LPHvcWI+pX81J9d0unln2LVcdhIBFuvHskRQ6dojfsUH0q9o8pdK8+RBL8zMYzhc9aX06eA4pedZlerVk6Ux0hSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791717437; c=relaxed/simple;
	bh=E2P0hBoRI2/vcgFZgvc7u/D3Wv6gazBILmNlJPvVorE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=juUtFP2WrpHNbwxpIKGavYLZCVtAOYdm0Pwpflwnm3tAEgZ/CAeohPqMgo/k9r89f1OiYy1SJUBGvJlnykj5CbcOMBWjK0F4lc5ZTJ6x33HekzuNXo2Ue3K/585sMGOaLO4W3kw0XJAjCt5y8jvUxK9NVTjE02DFA/rq6YRrWYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daU/sgeb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daU/sgeb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193B01F0089E;
	Sun, 11 Oct 2026 11:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791717433;
	bh=/uCK/vlyqu6zpQ72l6lOprgq1YvuOYsvSDBZcgDR8UU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=daU/sgeb/5c8xfir1gLLkjTmnVM8LfVQnsMJWDSClQAaZV9HQRRWZGn5eQQFRuZHG
	 yuBXHlGbkelukxQwDmxN0yBELwhrv0vYfeWJlQnGSLnGkiDfqxBNQbcs0L7VZGwukk
	 i3IuuF8LaA0gnD8KLWd1I4QrLz9kM0WmEFY/FcPEBsDXCW4QL5uFHpy4A48jxJYmDk
	 EvswAoEyK3TIGb3UBtRnq5/G25qcwq9NuRw8Veq3Tmz5YwFqEdezsAbc6vvv8Q8uC+
	 brxR86XH4JkVUqumk3LqS+xbNoW6RhaALlR0ocdqDBxpQWAtzKFn/Fk8RDvOjDNgOQ
	 hkFjxsG/WmBRg==
Subject: Re: [PATCH net-next v5 5/5] selftests/net: Move the XDP feature test
 to drivers/net/hw
From: netdev-bot+sashiko@kernel.org
To: bochaolucky@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 andrew+netdev@lunn.ch, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 alexis.lothore@bootlin.com, lorenzo@kernel.org, tiozhang@didiglobal.com,
 willemdebruijn.kernel@gmail.com, petrm@nvidia.com
Date: Sun, 11 Oct 2026 11:17:11 +0000
Message-ID: <179171743168.434549.11373662965992474852@kernel.org>
In-Reply-To: <20261010-xdp-v5-send-20261008-v5-5-de687cb67c40@gmail.com>
References: <20261010-xdp-v5-send-20261008-v5-5-de687cb67c40@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The XDP_NDO_XMIT subtest fails on many drivers even when they
  work correctly, because the advertised mask is read before the XDP…
- [Low] The moved BPF object xdp_features.bpf.o is built by the shared
  rule in tools/testing/selftests/net/bpf.mk.
- [Low] run_feature() builds the local commands with shlex.join() (the
  probe at line 45, and the DUT command from feature_command() at line…
- [Low] tools/testing/selftests/bpf/.gitignore still has an
  `xdp_features` entry at line 44.
- [Low] The new README section heading 'XDP feature test' (16 characters)
  at tools/testing/selftests/drivers/net/README.rst:314 has a…

--

selftests/net: Move the XDP feature test to drivers/net/hw

This moves the xdp_features helper and its BPF program from selftests/bpf
to drivers/net/hw. It replaces the private veth shell script with a
NetDrvEpEnv Python test that runs the DUT locally and the tester remotely.
The new test compares detected features against the advertised mask with
ksft_eq().

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 883c92701b9f1..cb76b68c97dbb 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -142,7 +142,6 @@ TEST_GEN_PROGS_EXTENDED = \
>  	test_cpp \
>  	test_lirc_mode2_user \
>  	veristat \
> -	xdp_features \
>  	xdp_hw_metadata \
>  	xdp_synproxy \
>  	xskxceiver

[Severity: Low]
This isn't a bug, but tools/testing/selftests/bpf/.gitignore still has an
xdp_features entry. This patch removes the binary and its build rule from
this Makefile, and the ignore entry is now in drivers/net/hw/.gitignore.
Should the old entry be removed as well?

[ ... ]

> diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
> index 3fe49bce4f3a5..0791f02ba44b4 100644
> --- a/tools/testing/selftests/drivers/net/README.rst
> +++ b/tools/testing/selftests/drivers/net/README.rst
> @@ -310,3 +310,21 @@ Running tests CI-style
>  
>  See https://github.com/linux-netdev/nipa/wiki for instructions on how
>  to easily run the tests using ``virtme-ng``.
> +
> +XDP feature test
> +===============

[Severity: Low]
This isn't a bug, but the underline is one character shorter than the
title. "XDP feature test" is 16 characters and the underline is 15.
docutils warns "Title underline too short" for this.

[ ... ]

> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 18ce235a77f84..bd818e8625c23 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile

[ ... ]

> @@ -94,6 +95,18 @@ include ../../../net/ynl.mk
>  
>  include ../../../net/bpf.mk
>  
> +$(OUTPUT)/xdp_features.bpf.o: xdp_features.h
> +
> +$(OUTPUT)/xdp_features: CFLAGS += -I$(OUTPUT) -I$(SCRATCH_DIR)/include
> +$(OUTPUT)/xdp_features: CFLAGS += -I../../../net/lib
> +$(OUTPUT)/xdp_features: LDLIBS += -lelf -lz -lpthread
> +$(OUTPUT)/xdp_features: xdp_features.c xdp_features.h \
> +			   $(OUTPUT)/xdp_features.skel.h $(BPFOBJ)
> +	$(call msg,BINARY,,$@)
> +	$(Q)$(CC) $(CFLAGS) $(CPPFLAGS) $(KHDR_INCLUDES) \
> +		$(filter %.c %.o,$^) $(BPFOBJ) \
> +		$(LDFLAGS) $(LDLIBS) -o $@

[Severity: Low]
Only the userspace helper gets KHDR_INCLUDES here. Can xdp_features.bpf.o
fail to build in an O= build?

The BPF object is built by the shared rule in
tools/testing/selftests/net/bpf.mk:

CCINCLUDE += -I$(selfdir)/bpf
CCINCLUDE += -I$(top_srcdir)/usr/include/
CCINCLUDE += -I$(SCRATCH_DIR)/include
...
	$(Q)$(CLANG) -O2 -g --target=bpf $(CCINCLUDE) $(CLANG_SYS_INCLUDES) \
	-c $< -o $@

With make O=<objdir> headers, tools/testing/selftests/Makefile sets
KHDR_INCLUDES to ${abs_objtree}/usr/include. That leaves
$(top_srcdir)/usr/include empty in a clean source tree.

The #include <linux/netdev.h> in xdp_features.bpf.c then falls back to the
system headers. Those don't have linux/netdev.h on distros whose UAPI
headers predate 6.3, for example Ubuntu 22.04.

The old selftests/bpf build passed -I$(APIDIR), and that directory has
tools/include/uapi/linux/netdev.h. Should the BPF compile for this object
also get KHDR_INCLUDES or -I$(APIDIR)?

[ ... ]

> diff --git a/tools/testing/selftests/drivers/net/hw/xdp_features.py b/tools/testing/selftests/drivers/net/hw/xdp_features.py
> new file mode 100755
> index 0000000000000..1d59772b2a4d0
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/xdp_features.py

[ ... ]

> +def feature_command(binary, feature, dut_addr, tester_addr, ifname,
> +                    tester=False):
> +    """Build the helper command with the configured endpoint addresses."""
> +    args = [str(binary)]
> +    if tester:
> +        args.append("-t")
> +    args += ["-f", feature, "-D", dut_addr]
> +    if tester:
> +        args += ["-C", dut_addr]
> +    args += ["-T", tester_addr, ifname]
> +    return shlex.join(args)
> +
> +
> +def run_feature(cfg, feature, ipver):
> +    """Run one feature with bounded helper lifetimes and verify its result."""
> +    cfg.require_cmd("timeout", local=False, remote=True)
> +    probe = cmd(shlex.join([str(cfg.xdp_features), "-q", cfg.ifname]),
> +                fail=False)

[ ... ]

> +    dut_cmd = feature_command(cfg.xdp_features, feature, dut_addr,
> +                              tester_addr, cfg.ifname)
> +    tester_cmd = feature_command(cfg.remote_xdp_features, feature, dut_addr,
> +                                 tester_addr, cfg.remote_ifname, tester=True)
> +
> +    with bkg(dut_cmd, exit_wait=True, ksft_ready=True):

[Severity: Low]
Is shlex.join() right for the local probe and dut_cmd? The local path of
cmd() in tools/testing/selftests/net/lib/py/utils.py does not use a shell:

            if shell is None and isinstance(comm, str) and ' ' in comm:
                comm = comm.split()

Suppose the resolved path to xdp_features contains a character that
shlex.quote() escapes, such as a space, '~', '$', '(' or '!'. The added
quotes are then passed to execve() as literal characters.

Would Popen() then raise FileNotFoundError and crash every subtest?

Only tester_cmd goes through a shell, over ssh. Could the local commands
pass an argument list instead?

> +        # Bound the remote process itself, not just the local SSH wait.
> +        result = cmd(f"timeout --signal=TERM --kill-after=5 90 {tester_cmd}",
> +                     host=cfg.remote, timeout=100)
> +
> +    output = ANSI_ESCAPE.sub("", result.stdout)
> +    match = RESULT.search(output)
> +    if not match:
> +        raise KsftFailEx(f"Unable to parse xdp_features output: {output}")
> +
> +    detected = match.group(1) is None
> +    advertised = match.group(2) is None
> +    ksft_eq(detected, advertised,
> +            comment=f"{feature}: detected and advertised support")

[Severity: Medium]
Can this report a false failure for XDP_NDO_XMIT on drivers that only
advertise it after an XDP program is attached?

tester_run() in xdp_features.c reads the advertised mask before it asks
the DUT to attach its program:

	err = send_and_recv_msg(sockfd, CMD_GET_XDP_CAP, &advertised_feature,
				sizeof(advertised_feature));
	...
	err = send_and_recv_msg(sockfd, CMD_START, NULL, 0);

dut_run() answers CMD_GET_XDP_CAP with a live bpf_xdp_query(). It only
calls dut_attach_xdp_prog() when CMD_START arrives.

Several drivers set NETDEV_XDP_ACT_NDO_XMIT in their XDP attach path. One
example is virtnet_xdp_set() in drivers/net/virtio_net.c:

		if (!old_prog)
			xdp_features_set_redirect_target(dev, true);

ixgbe, i40e, ice, igb, igc, stmmac, funeth, libeth and bnxt do something
similar.

On those drivers the tester sees NOT ADVERTISED. Once the program is
attached, though, the redirected frames still come back through
ndo_xdp_xmit, so the output is:

Feature XDP_NDO_XMIT: [DETECTED][NOT ADVERTISED]

The removed shell script only checked the helper's exit code. Wouldn't
this ksft_eq() now fail on a driver that works correctly? Could the
capability query be moved after CMD_START?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010-xdp-v5-send-20261008-v5-0-de687cb67c40%40gmail.com
