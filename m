Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929230;
	b=yfeTc2b7I+b3IUhA2G8FGUADv8kIzT48DPt390297a4kAsHI9zFFh1lofPyoyxCu/TCg
	 BkPbZBnhI4N9VR64teYe1jw8j7CFv77I0h30jYc3mqz3y/H7kv+Ua2JY/CiHd3Y0TCDzj
	 +UGN1/cDSkJWbL1vSpmPCe46lpLuKv4Y11379BbxhhZz5MoNCi2e2Iq/mXzeyCrCvyYb9
	 nEo08usyKpfELwKPUP8PaRgsmyVITi+YGOkFeYxTPEohltJTAj1+hP+8BC+bdFGZ89dxt
	 Guus4eVwcO/Gub28Dl5WHU+VtNIPde0YxRw0wpgmetNy8X/iABtB2p709j9VUh+L5Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929230;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=J9lHZgigB7HZPUrEp8RihgD1dGtXtELcCnjY6ZtCrhs=;
	b=EXRv9n1o4l1onN4th9Bkam5cJwafO8xok12jExbUv2A11PMI5gHQlaABvzvj/0OyDNqs
	 XYKBJJWtAh27XVeW0SQ1TDo92CR+sYiMKgYm2VrY09Qc9uM0Js6wfsIF4N5vMe5M9zTMD
	 WeVaTRp7lps1m1xcz8jjAj7K+C4EUeUdWsclTXtCqCh4cXlJ6ASgjA0nRxutyywVfhiu+
	 Vz0w3C14TGZ6AxxXC0BtS8T5PBbazhps6JJFEpCMWnWQvk23kKqZ+PLghqLOEdyF6tcRY
	 3wBQItdGuzlXDOZ9xKuSTjJ0FbV36p2KkMvxCIupIAz4D5h+zivL1QZU96T5yl3UzyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k75pwJdo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE1C606A32C;
	Tue, 17 Nov 2026 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k75pwJdo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7411F000C6;
	Tue, 17 Nov 2026 15:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929230;
	bh=J9lHZgigB7HZPUrEp8RihgD1dGtXtELcCnjY6ZtCrhs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k75pwJdoFQa/+SvHhxy15foiEJtFPcUh0Et09CMALFEWwRR5NCRdP72n3NDlNeenk
	 FTzEru+nyDliQWDehVV8btV5wogdFEKpy5z2F4IknVpiYl5N4BCJQ3ld/N4Q459Ovr
	 KAG1hqBsTlVZFXTVNVUKWZpr7N23q18sEEerBBPbXMbRj9ISGp+wy3qL6yxAZo3E9N
	 RVDqIoKuQ0XRGKHXhwM9VnStgI/2Ec5JgNyr/VcT2/AW1RUDNeXKW3wT5rbmdqoOUm
	 X+83VcLiHdIpGdkSxSB4yNVT6FxlQiUUBLgrXQxTkj9z1TG88fPxiPvxjuqqBLP1+j
	 5DDsUhg37EOkQ==
Subject:
 Re: [PATCH v1] net: sock_reuseport: check program type on the migration path
From: netdev-bot+sashiko@kernel.org
To: shlomojune6@gmail.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, edumazet@kernel.org,
 kuniyu@google.com, pabeni@redhat.com, willemb@google.com, davem@davemloft.net,
 kuba@kernel.org, horms@kernel.org, audit@example.invalid
Date: Tue, 17 Nov 2026 15:27:09 +0000
Message-ID: <179492922969.3136.7887984434455212903@kernel.org>
In-Reply-To: <20261115152408.48205-1-shlomojune6@gmail.com>
References: <20261115152408.48205-1-shlomojune6@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: sock_reuseport: placeholder Signed-off-by trailer in commit
  message
- [Low] The commit message says loading a BPF_PROG_TYPE_SOCKET_FILTER
  program with expected_attach_type=BPF_SK_REUSEPORT_SELECT_OR_MIGRATE…

--

net: sock_reuseport: check program type on the migration path

This commit makes reuseport_migrate_sock() and reuseport_stop_listen_sock()
treat a reuseport program as migration capable only when its type is
BPF_PROG_TYPE_SK_REUSEPORT. Checking expected_attach_type alone allowed a
SOCKET_FILTER program to run with a struct sk_reuseport_kern context.

> A BPF_PROG_TYPE_SOCKET_FILTER program can be loaded with
> expected_attach_type set to BPF_SK_REUSEPORT_SELECT_OR_MIGRATE and
> attached to a SO_REUSEPORT TCP group; both steps are allowed without
> CAP_BPF.

[Severity: Low]
Is "both steps are allowed without CAP_BPF" accurate for a default
configuration?

In bpf_prog_load() in kernel/bpf/syscall.c, this check runs before the
SOCKET_FILTER/CGROUP_SKB exemption for unprivileged loads:

kernel/bpf/syscall.c:bpf_prog_load() {
    ...
	if (sysctl_unprivileged_bpf_disabled && !bpf_cap)
		goto put_token;
    ...
}

The sysctl starts at 2 when CONFIG_BPF_UNPRIV_DEFAULT_OFF is enabled:

int sysctl_unprivileged_bpf_disabled __read_mostly =
	IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;

That Kconfig option is "default y" in kernel/bpf/Kconfig. So on a default
kernel, a task without CAP_BPF (or a BPF token granting it) can't load the
socket filter in the first place. Unprivileged users can only reach the
out-of-bounds access when kernel.unprivileged_bpf_disabled has been set
to 0.

Could the commit message mention that the unprivileged case depends on
this sysctl? That would help backporters and security triage judge the
exposure. The code change itself is not affected by this.

[Severity: High]
The author and Signed-off-by trailer both use the identity
Linux kernel audit <audit@example.invalid>. That isn't a person, and
the .invalid TLD is reserved (RFC 2606), so the address can never
receive mail.

Signed-off-by is the Developer's Certificate of Origin described in
Documentation/process/submitting-patches.rst. It certifies that a
specific person wrote the change or has the right to pass it on under
the kernel's license. A placeholder identity can't make that
certification. Nobody can be reached at this address if questions
about the patch come up later, so this can't be applied as is.

Could you resend with the author and Signed-off-by set to your real
name and a working email address? If you're forwarding a change
written by someone else, it needs the original author's sign-off
followed by your own. The code change itself is not affected by this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261115152408.48205-1-shlomojune6%40gmail.com
