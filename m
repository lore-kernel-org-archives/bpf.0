Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD7D38A72A;
	Thu,  8 Oct 2026 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791495440; cv=none; b=b/DIopbi1GgRmZNnWzgmMJkoMxCr7JKy9kNN3WPRrU+XSonWT1GybKdOAhAgqEAl97OktAjxr31vzDuYzjRh+cEUMh4qXOG6B982t+YIrkIDZhC6lVWSyeAhF2vlXCJz4Xd1Q/X5QtP+0OMLbq/uICK8UGt7t/o/PMFz6Vjfix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791495440; c=relaxed/simple;
	bh=4Qim3+VE4g1EgcgDsjT/7r1pBLQ2Ihv/kCtPa9L/laU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqhGg2rliZFUp9u8HGgCvdLQltnAw5jbTyaJdZZBr2hVXJCg3BSc8YQYaU6/yE+qeiBgfRYK0pNB02H8P4UGx3MEOILs5Ripa8c3MLDIFrBB9x4+JCEALf6aHJrtMiOBzbjucMpwAcNCY6liMzh6nwpXSyj1DEA6Y1jj/phrwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnt2RJc4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnt2RJc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D891F000FF;
	Thu,  8 Oct 2026 21:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791495431;
	bh=+LyKwDPKKFRKj19ev0+ECVKpw5ONiAo55qUGYIxc/LI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lnt2RJc49mMFVOuJMgI02N7P8LBYVSwT+WZFUSQNHEu9aue8rJPdezvWaf3ZIcBRx
	 Bi/u30VI+4e4wWH7cGWTFRf+oj+skwS9bZavH5aL0b2KPLs4HL1bxVpQ4iIQCzkTtp
	 IrktZTBAPdmA6RUlcpn08gqXgv21J7Dk2vXoq7kdaH1FlANa7RNfFsC/jNkOjdJR4C
	 Qp9AtKTpfSNHFqeDiZHOcu+SHZUmCR02i0d+jFdn3L6cErV0AJNfx5Y9wHLjqhEipU
	 8tDJKEUo1IGmFO2lTAKxGgIIyazydvth308/94am6S79eObu8wRqcx7pd/uD7x/QMM
	 d/vUmpnGum8Cg==
Date: Thu, 8 Oct 2026 14:37:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, bjorn@kernel.org
Subject: Re: [PATCH v2 net-next 13/14] selftests: drv-net: test AF_XDP
 zero-copy with an SKB peer
Message-ID: <20261008143710.02cfcbf8@kernel.org>
In-Reply-To: <20261008114909.734364-14-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
	<20261008114909.734364-14-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Oct 2026 13:49:08 +0200 Maciej Fijalkowski wrote:
> +XSK_BIN = (Path(__file__).parent / "../../../net/lib/xskxceiver").resolve()

cfg.test_dir ? Please don't reinvent the wheel

> +XSK_CASES = XSK_BIN.parent / "xsk/test_xsk_case_defs.h"

> +def _hardware_cases():
> +    defs = XSK_CASES.read_text()
> +    entries = re.findall(r"(?m)^XSK_TEST_CASE\((\w+),\s*\w+,\s*([^)]+)\)", defs)
> +    if not entries or len(entries) != defs.count("XSK_TEST_CASE("):
> +        raise KsftFailEx(f"cannot parse {XSK_CASES}")
> +    variants = []
> +    for test_id, (name, hw) in enumerate(entries):
> +        flags = {flag.strip() for flag in hw.split("|")}
> +        if not flags <= {"0", "XSK_HW_RX", "XSK_HW_TX"}:
> +            raise KsftFailEx(f"invalid hardware directions for {name}: {hw}")
> +        variants += [KsftNamedVariant(f"{d}_{name.lower()}", name, d, test_id)
> +                     for d in ("rx", "tx") if f"XSK_HW_{d.upper()}" in flags]
> +    return variants

?? Just list them, don't over optimize for de-duplication
it's obviously all LLM generated now.

> +def _netns_remote(cfg):
> +    return cfg.env.get("REMOTE_TYPE") == "netns"

You shouldn't have to care, please don't break the abstractions

> +def _control_addr(cfg):
> +    """An SSH remote is reached over its management link. A netns remote is
> +    reached only over the tested link, where the XDP programs pass the
> +    control connection to the stack."""
> +    if _netns_remote(cfg):
> +        return cfg.remote_addr_v["4"]
> +    return cfg.remote.name.rpartition("@")[2]

Suspicious? Not sure why you need this. No existing test does
something like this

> +def _root_cmd(command, host=None, sudo=False, **kwargs):
> +    if sudo:
> +        command = "sudo -n " + command
> +    return cmd(command, host=host, **kwargs)

No hacks like this please, all networking tests can assume root

> +def _remote_binary(cfg, local_binary):
> +    binary = cfg.env.get("XSK_REMOTE_BIN")

Why this variable? Just assume the binary in tree is the one we need?

> +    if not binary:
> +        return cfg.remote.deploy(local_binary)
> +    if cfg.env.get("REMOTE_TYPE") != "ssh":
> +        raise KsftSkipEx("XSK_REMOTE_BIN requires the SSH remote backend")
> +    if cfg.env.get("XSK_REMOTE_DEPLOY", "1") == "0":
> +        result = cmd(f"test -x {shlex.quote(binary)}", host=cfg.remote,
> +                     fail=False)
> +        if result.ret:
> +            raise KsftSkipEx(f"remote xskxceiver is not executable: {binary}")
> +        return binary
> +    upload = binary + ".upload"
> +    cmd(["scp", "-q", str(local_binary), f"{cfg.remote.name}:{upload}"],
> +        shell=False)
> +    cmd(f"mv -f {shlex.quote(upload)} {shlex.quote(binary)}",
> +        host=cfg.remote)

Why any of these hacks/complexity? I think you need a better LLM and
point it at the existing tests. Weird stuff going on here :(
