Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699468;
	b=psfzQHy7uwgIjM1v9olAoUJ7chvJMeNppQCMJBJDAb1KMSkltLm/LSOMw+Zoc9+BeWZe
	 AGlqu0GQ7KvSg/kG563APJOVFuxTIU+1hNlRPj4C/YRqWzErOXFEyPNi489z4ytB9wYqD
	 dxubU8iQoEB6lBa1VvgJV7QHkXSxpHRkPuNgwLakY8khwmpW1plxKFRzjXCgxqXIUyypr
	 JcqOdysFKV9zVBFasQJOFx4QSwIoNzanlHaqD2OqhqNhNwi1IupKoC2k+b73Rq2mnsx+6
	 ek4ELN2BRDcA4mR7dNtlrigRv1ujsQSRg2a2iF/Pt+tg+d8div+gh98qvmPuc5uCNIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699468;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RhEbnMmGrCqnijsiYl47iarvijqRcqNzfttKNpI1cSI=;
	b=gMJyH4DlpkZN2FX4+RKhP4zO43jy4+tc5R1+v1kGvcai6GZB1Mozbo5y1RRw1ABEUVjU
	 mHwUqQvJwhZ/feXy4E2hnAd5ExWYj4rN0lD1PbIbRoya3XUw6mqiuCJKrlHGW/nlCabYU
	 EdvwxYBrjhE35iOoZah0eTsp5ghFQV7BB3sVhTmJcGKov51nUa5NzHgHDzvzekxq6deX/
	 pEhsraQR1HLStr62HXvrX74er2Smm3iXeaEAvrkxG6TTy7Phj3fk9JQsFV3Ba8QL5Mihn
	 Vu6LiVpRisQ6V8FA7fWEEmtoQqfsEc7ANF/OVUCXF7GrVgqAjT8n2d4eYhk7uBHairA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQ7zk4mk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF96606A31C;
	Thu, 26 Nov 2026 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQ7zk4mk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0851C1F00A03;
	Thu, 26 Nov 2026 13:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699468;
	bh=RhEbnMmGrCqnijsiYl47iarvijqRcqNzfttKNpI1cSI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YQ7zk4mkbGtDJgk5xQydLvJJ5d9RThI9GjbXJuoJi8/T2bwEsBnLDP/Wt3PLrhxAS
	 TaAY7Gk1RPJ8tOevqNoeZhALIyQDlbO5TdoyepzVs3FMLpP/9+9Np/JegT/c5Fb1qF
	 OMr5EsSLWyhNEGdS6J9/Hlz8ARY4ttNtla6zAqSQdqNATXqjZZkYf3TzVV6yV7doj5
	 XJlgEvhHhqfrrJA2bNhzBy7rJ2mJOM8oc9LXsQNSyl/7IjMTDTJoqExmznWwIUG/Xp
	 WNpBGPt6RPD/zQr3o4HVHJXhIDzhusAQ22kvo2lzEgfszEV8Zll5aJkQ7s2VDST6ab
	 18K8AwNHYSquQ==
Message-ID: <sashiko-outbox-235594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/18] rv: Add generic monitor event tracepoints and
 BPF kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261126130004.127155-6-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com>
 <20261126130004.127155-6-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 13:24:27 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] rv: undefined tracepoint symbols when CONFIG_RV_MON_EVENTS is
  unset
- [Medium] rv: TOCTOU unbounded strlen() after strnlen() in
  bpf_rv_*_monitor()
- [Low] rv: missing @id__nullable kernel-doc description in rv_bpf.c
--

commit 12ad0d7960250beaac1afe9380fabf830419122f
Author: Gabriele Monaco <gmonaco@redhat.com>

rv: Add generic monitor event tracepoints and BPF kfuncs

This commit adds generic event_monitor and error_monitor tracepoints along
with bpf_rv_event_monitor() and bpf_rv_error_monitor() BPF kfuncs so BPF
monitors can emit RV events and errors.

> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index c895d81dfdad9..588250ce3fa93 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -3,6 +3,7 @@
>  ccflags-y +=3D -I $(src)		# needed for trace events
> =20
>  obj-$(CONFIG_RV) +=3D rv.o
> +obj-$(CONFIG_RV) +=3D rv_bpf.o
>  obj-$(CONFIG_RV_MON_WIP) +=3D monitors/wip/wip.o
>  obj-$(CONFIG_RV_MON_WWNR) +=3D monitors/wwnr/wwnr.o
>  obj-$(CONFIG_RV_MON_SCHED) +=3D monitors/sched/sched.o

[Severity: Medium]
Does this fail to link when CONFIG_RV=3Dy is enabled without any in-kernel C
monitor?

rv_bpf.o is built whenever CONFIG_RV is set and calls trace_event_monitor()
and trace_error_monitor(), but CREATE_TRACE_POINTS in kernel/trace/rv/rv.c
is only defined under CONFIG_RV_MON_EVENTS:

kernel/trace/rv/rv.c:
    #ifdef CONFIG_RV_MON_EVENTS
    #define CREATE_TRACE_POINTS
    #include <rv_trace.h>
    #endif

CONFIG_RV_MON_EVENTS is only selected by the in-kernel C monitor options
(all of which default to n), so a BPF-only RV build leaves
__tracepoint_event_monitor, __tracepoint_error_monitor, and their static
call symbols undefined at link time.

> diff --git a/kernel/trace/rv/rv_bpf.c b/kernel/trace/rv/rv_bpf.c
> new file mode 100644
> index 0000000000000..f39f33335c71b
> --- /dev/null
> +++ b/kernel/trace/rv/rv_bpf.c
> @@ -0,0 +1,76 @@
[ ... ]
> +/**
> + * bpf_rv_event_monitor - emit an RV monitor event tracepoint
> + *
> + * @msg must be NULL-terminated, drop the event if it isn't. This happen=
s by
> + * construction if using snprintf-like functions and passing the right @=
msg__sz
> + * to both.
> + *
> + * @mon__str: name of the monitor
> + * @msg: message string
> + * @msg__sz: message string size
> + *
> + * Return -EINVAL if @msg is not NULL-terminated, 0 otherwise.
> + */
> +__bpf_kfunc int bpf_rv_event_monitor(const char *mon__str, const int *id=
__nullable,
> +				     const char *msg, u32 msg__sz)

[Severity: Low]
Both bpf_rv_event_monitor() and bpf_rv_error_monitor() use kernel-doc
comments but omit @id__nullable, which triggers kernel-doc warnings under
W=3D1 builds.

> +{
> +	if (strnlen(msg, msg__sz) =3D=3D msg__sz)
> +		return -EINVAL;
> +
> +	trace_event_monitor(mon__str, id__nullable, msg);
> +	return 0;
> +}
> +
> +/**
> + * bpf_rv_error_monitor - emit an RV monitor error tracepoint
> + *
> + * @msg must be NULL-terminated, drop the event if it isn't. This happen=
s by
> + * construction if using snprintf-like functions and passing the right @=
msg__sz
> + * to both.
> + *
> + * @mon__str: name of the monitor
> + * @msg: message string
> + * @msg__sz: message string size
> + *
> + * Return -EINVAL if @msg is not NULL-terminated, 0 otherwise.
> + */
> +__bpf_kfunc int bpf_rv_error_monitor(const char *mon__str, const int *id=
__nullable,
> +				     const char *msg, u32 msg__sz)
> +{
> +	if (strnlen(msg, msg__sz) =3D=3D msg__sz)
> +		return -EINVAL;
> +
> +	trace_error_monitor(mon__str, id__nullable, msg);
> +	return 0;
> +}

[Severity: Medium]
Can a concurrent update to msg after strnlen() cause trace_event_monitor()
or trace_error_monitor() to read past msg + msg__sz?

For the (const char *msg, u32 msg__sz) kfunc argument pair, the BPF
verifier accepts any writable BPF memory region of size msg__sz, including
shared BPF map values.  event_template_monitor uses __string(msg, msg),
which runs an unbounded strlen(msg) and memcpy() after strnlen() has
already returned:

CPU0                                  CPU1
bpf_rv_event_monitor(mon, id,
                     msg, msg__sz)
  strnlen(msg, msg__sz) < msg__sz
                                      /* overwrites NUL byte in shared
                                       * BPF map value backing msg
                                       */
  trace_event_monitor(mon, id, msg)
    strlen(msg)
    memcpy(..., msg, ...)             <-- out-of-bounds read past msg__sz

Reading past the end of a BPF map allocation can fault on an unmapped
vmalloc guard page or copy adjacent kernel memory into the trace ring
buffer.  Passing the length returned by strnlen() into the tracepoint and
using __string_len() in event_template_monitor would bound the copy without
re-scanning msg.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126130004.1271=
55-1-gmonaco@redhat.com?part=3D5
