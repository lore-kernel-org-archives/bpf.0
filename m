Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793273285;
	b=pUPt6hDxXYRJ30SRyBaSnyU5/bAGZkihLkwv4ZVETHV2GYN/vuBsp0G2kZ04oRuIRqpG
	 8IyCXgITgYC7173q8NZ4Sa7bzM5FgEke8ylGFsQARhLFHUxoMozskcxxkowwG6oZkdW59
	 9LJFsnSqs9KPAG0YgeuYqfgjQT+hYK7BFUZ2hOFyAbS7ruUNns0THdMH9sRxf45Iy7r7J
	 679vPcNRIDpg736xmydH0/5BiW3TqGusjz/hNHgCZeRQ6fITEJ4uePaB+91k5DfFmdNJD
	 sTqv6KKKJKeMHJLZszSZ/85AKLeihQ63B+P2xEXlq9evvjl6AK+xxdEkIEHoYfHDPRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273285;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Infomaniak-Routing;
	bh=LaD9WrR+AACReb/Fw3idhuufgElFfvZMlx/OJIXbArA=;
	b=GXWqbreuafq+wq+pBRJblJskeE6osmq76wNWkup3woVDDNQFrjcnLM5XIJYZ9Wmf3R4B
	 JGTQLOwPJccXXA5tGllQoFNhfbObmK7tZqOsM3OQVY3XUl1XOtjFxuFnuEThECQ0/qwD9
	 SlkHCew9WR0MdZ7LGMaoNz8WUod769RMzA3dF0ybtn+rfWiv6p0hyhKN5WjMSaoAKtrF8
	 8eOU+zbCdx9Mk9JehnNNCrVgUHHGfsRkthW8hkUu5iXsH/ZqFYZ2zKCPeS7/6ERSZt2Pc
	 FT4DIbSXUZDjmU5Wv39pDub0qL+PhzhyeR2/c2QEMs4dR4SoIb4aSypl/i3bU9efe5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=GzCpnY9w;
	arc=none smtp.remote-ip=84.16.66.173
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D2606A31F
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 11:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 369D2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=GzCpnY9w
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jFhmS6Y9lzn3b;
	Thu, 29 Oct 2026 12:27:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1793273272;
	bh=LaD9WrR+AACReb/Fw3idhuufgElFfvZMlx/OJIXbArA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GzCpnY9wpDf60mcnYuroXbFa9YCakGFBrOjfurb2f7UxJM3jUmzmm71A+H/ex0U95
	 Ezw0UDC5/DXLdfO9xfh2E7NHLu4mmTw+EV8TXVuVR5Zv2qJiAyasin7EDuqpetc/yo
	 QmYhNWapgWaCBAEkibByaPzDgOQutFwZnHYo9qng=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jFhmR4mH2z8lf;
	Thu, 29 Oct 2026 12:27:51 +0100 (CET)
Date: Thu, 29 Oct 2026 12:27:47 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
	stable@kernel.org
Subject: Re: [PATCH 4/8] landlock: pass the namespace id to log to
 check_ns_type()
Message-ID: <20261028.oonaisai0Doh@digikod.net>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
 <20261026-work-security-namespace_free-v1-4-ffa3ebbf71bd@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026-work-security-namespace_free-v1-4-ffa3ebbf71bd@kernel.org>
X-Infomaniak-Routing: alpha

On Mon, Oct 26, 2026 at 10:57:12AM +0100, Christian Brauner wrote:
> Landlock logs the namespace id when it denies the use of a namespace.
> check_ns_type() takes it from the namespace itself. When it is called
> from the namespace_init hook the id is always zero as it is only
> allocated after the hook has run.
> 
> A follow-up patch will allocate the id before the namespace_init hook is
> called. But a namespace whose creation is denied never becomes visible
> and the Landlock documentation says that namespace_id is zero for
> namespace creation (cf. Documentation/admin-guide/LSM/landlock.rst and
> Documentation/trace/events-landlock.rst). So pass the id to log to
> check_ns_type() and keep passing zero from hook_namespace_init().
> 
> No functional changes.
> 
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  security/landlock/ns.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/security/landlock/ns.c b/security/landlock/ns.c
> index cd44c927f83a..39795c4e1404 100644
> --- a/security/landlock/ns.c
> +++ b/security/landlock/ns.c
> @@ -90,15 +90,16 @@ static const struct access_masks ns_permission = {
>   * check_ns_type - Check namespace use permission
>   *
>   * @ns: The namespace being allocated or installed.
> + * @ns_id: The namespace id to log.
>   *
>   * Shared check for namespace_init (creation via clone(2), unshare(2),
>   * open_tree(2), or fsmount(2)) and namespace_install (use via setns(2)): denies
>   * when the namespace type is not in the domain's allowed set.  At allocation
> - * time @ns->ns_id is still zero and is logged as such.
> + * time the namespace isn't visible yet so @ns_id is zero.
>   *
>   * Return: 0 if allowed, -EPERM if denied.
>   */
> -static int check_ns_type(struct ns_common *const ns)
> +static int check_ns_type(struct ns_common *const ns, const u64 ns_id)
>  {
>  	const struct landlock_cred_security *subject;
>  	size_t denied_layer;
> @@ -121,7 +122,7 @@ static int check_ns_type(struct ns_common *const ns)
>  				    .permission =
>  					    LANDLOCK_PERMISSION_NAMESPACE_USE,
>  				    .audit.u.ns.ns_type = ns->ns_type,
> -				    .audit.u.ns.ns_id = ns->ns_id,
> +				    .audit.u.ns.ns_id = ns_id,
>  				    .layer_plus_one = denied_layer,
>  			    });
>  	return -EPERM;
> @@ -129,13 +130,13 @@ static int check_ns_type(struct ns_common *const ns)
>  
>  static int hook_namespace_init(struct ns_common *const ns)
>  {
> -	return check_ns_type(ns);
> +	return check_ns_type(ns, 0);

The use of 0 as a namespace ID in logs was mainly a consequence of the
hook implementation and the fact that no ID were visible to user space.
This changes with this series: the kernel allocates a new ID and other
LSMs see this newly created ID.  Landlock's logs should follow this
change consistently and always reflect the real namespace ID instead of
faking it with 0 for namespace creation.

Could you please update the doc and tests instead?  The doc should still
warn that when blocking a namespace creation, the logged namespace ID is
still not *directly* visible from user space.

Being able to differentiate namespace creation (i.e. when a namespace is
not yet reachable by user space) from a namespace enter operation is
important for Landlock from an observability point of view.  We then
need at least the Landlock tracepoints to make this possible.  I'm
working alongside what you're doing and I'll send patches next week.

>  }
>  
>  static int hook_namespace_install(const struct nsset *const nsset,
>  				  struct ns_common *const ns)
>  {
> -	return check_ns_type(ns);
> +	return check_ns_type(ns, ns->ns_id);
>  }
>  
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
> 
> -- 
> 2.53.0
> 
> 
