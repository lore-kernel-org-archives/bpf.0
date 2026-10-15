Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC92374A12
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090006; cv=none; b=OCESj7vuxIg3cBF7ONPznSld7LeE+xptdcg6qkSHxUFWzUGbyTKS/TJAGfpKz22rGDWk7CA3OTO/2jcE8NpG8LcbaZReCZZNBAayumy0r8g5lUZiTbKXjLgTJT+MgsxU0I6JtwyRwZH+PO1GpI+JWTgjlnRQ3WI5bFFo1iBcOBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090006; c=relaxed/simple;
	bh=OMrrimaCvV8ecAAb4VROvxt7F07fomEW41CZS4YlorM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CTF4YoSPxbf3lsfAS++anPElHkOL5jrnzzAbbyUR8xZf3stLSIT4h5e2uoV/QTw0161Ep5raE3CltXL90S8VOKxTcsCIhXNaPeIk2x9XMvVqeicZcnvR8K8VraqSDgObrTT6fCXClMsTaXgxv0ooDX597RkKKNaR7TcF+uMGbdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiCobKV9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiCobKV9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE0D1F000C5;
	Thu, 15 Oct 2026 18:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792090003;
	bh=5MgkI2yGcG6BSMVD+XVC/HPcbg9XULdbG81UW475TLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YiCobKV9spylcd353ytzRsZSGdzS0mhn4JuCABuTPo5izumnSSHyOhEOv19N1Z0Fm
	 jzc/HZUe0jZn0HgXJpOV7b9kyRske/UyUWuJX8vAe5xpIZ69b+irlm+ki6LPSiKaCR
	 7Cfx/r83aEMKtdF1P9mXXnhctg98LFVkme18isTEuWTqJwMkL5GQmPMqSbkUCLXB87
	 N4UdvfG/+oyL6e79YgNUyVjS91sRrbR9VZPpvh2kZFhapInU6I3OB1paZ3Xb745Ead
	 36SGl91pGgxklWAklKQO5uwUfmbq9Wb8ifWsNtQVGhVMImJfInhh4+EIyY3jPugiD9
	 uzAxtkBvETsdg==
Message-ID: <sashiko-outbox-173329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 net-next 09/15] selftests: xsk: run one test case per
 xskxceiver invocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261014184539.774708-10-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-10-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:46:42 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests: sysctl leak of vm.nr_hugepages on exception
- [Low] selftests: unused argument in ksft_print_msg() format string
--

commit 7acec71c768966e15c22ec5e2e55704dfaf4978e
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

selftests: xsk: run one test case per xskxceiver invocation

This commit replaces test_xsk.sh and xsk_prereqs.sh with test_xsk.py to run
xskxceiver once per mode and case. This ensures that every test case runs i=
n a
fresh process and crashes only fail the specific test.

> diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/tes=
ting/selftests/net/lib/xsk/xskxceiver.c
> index 02e54b026806b..09ad623333be5 100644
> --- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> +++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> @@ -169,14 +164,14 @@ static struct option long_options[] =3D {
>  static void print_usage(char **argv)
>  {
>  	const char *str =3D
> -		"  Usage: xskxceiver [OPTIONS]\n"
> +		"  Usage: xskxceiver -i TX_IFACE -i RX_IFACE -m MODE -t TEST [OPTIONS]=
\n"
>  		"  Options:\n"
>  		"  -i, --interface      Use interface\n"
>  		"  -v, --verbose        Verbose output\n"
>  		"  -b, --busy-poll      Enable busy poll\n"
> -		"  -m, --mode           Run only mode skb, drv, or zc\n"
> +		"  -m, --mode           Mode to run: skb, drv or zc\n"
>  		"  -l, --list           List all available tests\n"
> -		"  -t, --test           Run a specific test. Enter number from -l opti=
on.\n"
> +		"  -t, --test           Test case to run, a number from -l\n"
>  		"  -h, --help           Display this help and exit\n";
> =20
>  	ksft_print_msg(str, basename(argv[0]));

[Severity: Low]
Does this code silently ignore the executable name argument? The format str=
ing
in 'str' does not contain a '%s' specifier, so basename(argv[0]) is not pri=
nted
when print_usage() is called.

[ ... ]

> diff --git a/tools/testing/selftests/net/test_xsk.py b/tools/testing/self=
tests/net/test_xsk.py
> new file mode 100755
> index 0000000000000..acfdba55fbae8
> --- /dev/null
> +++ b/tools/testing/selftests/net/test_xsk.py
> @@ -0,0 +1,140 @@

[ ... ]

> +def main():
> +    # ksft_run() exits on -l and -h before main() restores the huge page=
s.
> +    if "-l" in sys.argv or "-h" in sys.argv:
> +        sys.exit(f"{sys.argv[0]}: -l and -h are not supported")
> +    if not XSK_BIN.exists():
> +        print(f"1..0 # SKIP {XSK_BIN} was not built")
> +        sys.exit(SKIP_CODE)
> +    saved_hugepages =3D []
> +    hugepages =3D xsk_reserve_hugepages(saved_hugepages)
> +    cases =3D _get_cases(hugepages)
> +    ksft_run([ksft_variants(cases)(test_xsk),
> +              ksft_variants(cases)(test_xsk_busy_poll)])
> +    xsk_release_hugepages(saved_hugepages)
> +    ksft_exit()

[Severity: Medium]
Can this leak the host's vm.nr_hugepages sysctl modifications if an excepti=
on
occurs?

If _get_cases() or ksft_run() raise an unhandled exception (such as a
CmdExitFailure if the executable crashes, or a KeyboardInterrupt), execution
will terminate before reaching xsk_release_hugepages().=20

Should these calls be wrapped in a try/finally block to ensure hugepages are
properly restored?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014184539.7747=
08-1-maciej.fijalkowski@intel.com?part=3D9
