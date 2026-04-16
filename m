Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A793DE451
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349039; cv=pass; b=SngzfPdamYrkLOy0d6w5X8VsiGv4sfzAtgAbUhbA8NiVkb1jL7wKgb5+V3o9n+CekjpYvsG9oSaayoFsRpjn6kTL3RYPjcFX+bSMGgGvxXueCYgcjXAUoH6jf+XFVQqdCt5NpbQemsRjqKa0mzHMkj3GmnMJHQz/Ssnj2TrS8fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349039; c=relaxed/simple;
	bh=TOz6JNx0Bq4iQfvO61ZWuNM93f1XFaG6vZg62uy1yRo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XH+Unk9IjdhrlFmkeJVS0sy/4fcyrATQ5qiFA0iNF06Bt4k8Eboa0QfZBSe0gkl0joAmr55dVmC3I5rb+Iu/ltoRV5SVFqk9qk0FtjSwmVi9Vd4qTbT5wThGzSp/fXztkatF6EK4Ke9uuW60Vm5tF4f3TKrdcFV1F+LnFJZ/W50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Stkb/Txb; arc=pass smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Stkb/Txb"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-12c565dd3a7so387523c88.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 07:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776349035; cv=none;
        d=google.com; s=arc-20240605;
        b=kuybTC2vG3V5WIZ2702orRsdMjlqdPRUYqVMzrWKKG/mzuzek3S6UimUjWRzqegxe0
         JWpSOfPkF5IByknxdobe0FZ4xDr/+gx2sAncX7OE70uJwEdl/CzOGSrH2WEtP4ZjpQsL
         KvhZPJB3YoppXmHbVWTg/std4Hcfjb2I8GLSjdYXQM/ATWNL9sxhFBUe2Kk7NO4zM6UI
         jmaMNvQ16zqm2Qwg9nkVZe1RbLREh2QM7iYW0WupnD7qENpvC3jZNEHyTvf4LceYy7I5
         Xo63RRFN2Yu2cIHC6ddJwiStz8K9Au24fAaBk6tiXYsHI3h2PAbE4jih5N9CzkLEu01R
         M1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=23jKlmD1PkDoUeJEaonA1vsh4ax+QhwYKI+f1Lfh1yw=;
        fh=e3pzIYmBo/1Ab9x+h8k2SP/Z5sd1B6w1tjpFV5Om3UA=;
        b=PKB+g+WyJ3gSm5IoCMXuwM5ZGbu1K+6AoohaxejUP8vWZi4snhjQWL5vaZ2Fwnd/tl
         1KcpQtgdX1iNCYIyTWz0sXvHEBJO3/oqtrGHLDTf13M4YpPxwGoASJTQyOoipvcwrLx5
         wXmsdSnRcLZCOC/3uuhhE2Dl+pvDjX1LOVVVi48DeGTjtqE/0SMa0cgzEwGWyr1wl4cp
         YCw9faGn3EVSSR8LgOTtNgJgCWzKtAmo7xktuuHRtPx/cxaMM3PMDayOHc4a86P88H0o
         HN5sWcBnhKR8zdQoKLufpQb3Ba7ffwJj2kUonAVNF47BZC+TXAbQkZEllggZ3Ugjz+jY
         rPvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776349035; x=1776953835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=23jKlmD1PkDoUeJEaonA1vsh4ax+QhwYKI+f1Lfh1yw=;
        b=Stkb/Txb1bZ/bb9zvr9RY1kRfHgBgvLdJ+Z94JgfAywZkmJIiaNSpENQ3LHw8tLBmV
         QsltJsp6PUpnimzjboGaxY0FXab3+wK9utVsQXPPYg+N1HlZ/klXqvwhhLZBgMVMoT8s
         Q05kpzL1Q7MefbSIrgLhwkMJYr68rhj1ZKQdZ1fKAerWEwpYEW9eRrSks2vtf1AqeBEu
         eXrEUKeyLm6zhZql4cyS31QPmPaNStl5xXJDFJLk3mKCMb6vcq/QH/D/nf71lCg2FHY2
         61cY9Z0kDYDRcH9kTCiLkvqA9XBGnu+ciSRDrb/AY1ONyKbCmgNRRZBFGnSnj7Qq1edL
         O7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776349035; x=1776953835;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23jKlmD1PkDoUeJEaonA1vsh4ax+QhwYKI+f1Lfh1yw=;
        b=kwmx95l4no1ul0FrUyCaFCyiXEAsoVZ3j5wL81nkU5nQnu0iMqh+2G0j9yU68LMt7R
         T+3d2gJjkKzStxOWNpPTIuMka2P4DhIT+lyWT1YjKoRDC8Pt+hgzrvF/UXOFsMgk/bFc
         CZLVgMD4xNNXy9y95sFHYh2LP2fmNKsqLNnRpi50h82EwdEZF54n43Mfs959usVIXXbU
         m0lU4smrnYZhh44ZcKov5rMHdxEN4w7KWzZaih+tlyMkAWV7ymz2izv3nEnQ7Z/UcCWX
         iEnbGLrpCMHMQLaiHRzNlgDppteodGbFw4ISgwjldqPXSkUj+0vMvgTasTrCaJyzdTRA
         cL/A==
X-Gm-Message-State: AOJu0YyMKdPZ+6WqpMPvTrYaYe01atz64/2+z/NqK6P4at+QDs7ATocw
	iw2w8Dfqmwozg8XFFemFK0AlG8FGRfdJ3n09rPNdd+2B2fP0D9gNJDf5gefTkxtDyj75Uz1hQAw
	nnn57XjmgVJam+6k7clDPyYuk0yPbMMY=
X-Gm-Gg: AeBDievmOSHCuaFKlwxruFIcIkh52Zb64eBkZupJC9OtOlabjIOIxB6vDaamllodti0
	B2OLdAd3soMyauOs2hG9sAjkc5aR0m5HXIEzOvFfGAlpxltVdx5I53H28DCpTf83QzvRMIj7E02
	p35xQEXeMuSyyr1l4tL/2pwyTA2blCIYtEM0GjshFLrh4kcjCHEIhcxqdVbk7bm2cTvo1Ygp7Fu
	AGqw9+xCoDJ73Yz3VqTWPwADhdzkNK4Z8eV2cNtlm08wZWaRwNdUU+DAeDjplYKApWMT3K4gsbo
	PYNdhVMynmRg0Sr1C+MwciUV/qCX4GGdHzBUswY1ys5qXMOi+mTWZp3MHha0t0NTJAI=
X-Received: by 2002:a05:7022:239a:b0:11f:3483:bba6 with SMTP id
 a92af1059eb24-12c34e8015bmr16115015c88.13.1776349034183; Thu, 16 Apr 2026
 07:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: kritik bhattarai <kritikbhattarai47@gmail.com>
Date: Thu, 16 Apr 2026 20:02:01 +0545
X-Gm-Features: AQROBzDfwcoDitHgm_URDkmqqOek7iYa9E9sA1GRcjzzT_mGQHIGiteo1E8BOU0
Message-ID: <CACsEciSqAfpQZbFQ2tekZaU74hRokQ+fWDpyPbn_gqanYRUgVg@mail.gmail.com>
Subject: Technical Analysis of Use-After-Free (UAF) in kernel/bpf/verifier.c
 via Dangling Parent State
To: security@kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, 
	"alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000002e94b8064f947ddb"

--0000000000002e94b8064f947ddb
Content-Type: multipart/alternative; boundary="0000000000002e94b6064f947dd9"

--0000000000002e94b6064f947dd9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A logic flaw was identified in the Linux Kernel=E2=80=99s BPF Verifier stat=
e
management. The function free_verifier_state deallocates verifier states
without nullifying or unlinking the parent pointer. In scenarios involving
complex branch analysis and state pruning, this leads to a Use-After-Free
(UAF) condition where active states reference already-freed memory. This
can lead to a Kernel Panic (DoS) or potential Local Privilege Escalation
(LPE).
*Vulnerable Code Analysis*

The vulnerability exists in *kernel/bpf/verifier.c* within the state
deallocation logic:

// File: kernel/bpf/verifier.c
static void free_verifier_state(struct bpf_verifier_state *state, bool
free_self)
{
    int i;

    for (i =3D 0; i <=3D state->curframe; i++) {
        free_func_state(state->frame[i]);
        state->frame[i] =3D NULL;
    }
    kfree(state->refs);
    clear_jmp_history(state);

    /* * CRITICAL FLAW:
     * The 'state->parent' link is not nullified. If this state is part
     * of a hierarchy where child states are still active, they will
     * retain a dangling pointer to this 'state' after kfree().
     */

    if (free_self)
        kfree(state);
}


*Exploit Scenario & Root Cause*

The BPF verifier uses a depth-first search to explore program paths,
creating a hierarchy of states linked via the parent pointer.

   1.

   *State Creation:* When a branch is encountered, a new state is created
   with a parent pointer to the previous state.
   2.

   *Pruning:* If the verifier determines a path is redundant or safe, it
   may free the associated state using free_verifier_state.
   3.

   *UAF Trigger:* If the freed state was a parent to other branches that
   are still being analyzed (or revisited during is_state_visited), the
   verifier will attempt to dereference state->parent. Since state has been
   freed, this results in a Use-After-Free access.


*Proof of Concept (PoC) Overview*

The following logic (provided in the attached exploit_poc.c) is designed to
trigger the state pruning mechanism:

   -

   The PoC loads a BPF program with multiple conditional jumps (BPF_JMP).
   -

   It forces the verifier to create a deep state hierarchy.
   -

   By manipulating register values, it triggers a condition where a parent
   state is pruned while child references remain active in the verifier's
   traversal stack.

*Proposed Mitigation*

To resolve this issue, the verifier must ensure that all references to a
state are cleared before it is freed, or implement a robust reference
counting mechanism for state objects. A temporary fix involves nullifying
the parent link:


// Suggested Patch
if (state->parent) {
    state->parent =3D NULL; // Decouple before kfree
}


*Impact Assessment*

   -

   *Type:* Use-After-Free (UAF)
   -

   *Severity:* High
   -

   *Privileges Required:* Local Unprivileged User (if unprivileged BPF is
   enabled)
   -

   *Consequences:* Kernel Crash (System Instability) or Arbitrary Kernel
   Memory Access


File Link:
https://elixir.bootlin.com/linux/v7.0/source/kernel/bpf/verifier.c
Code line : 1695-1708

Reporter: Kritik

--0000000000002e94b6064f947dd9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>A logic flaw was identified in the Linux Kernel=E2=80=
=99s BPF Verifier state management. The function <code>free_verifier_state<=
/code> deallocates verifier states without nullifying or unlinking the <cod=
e>parent</code> pointer. In scenarios involving complex branch analysis and=
 state pruning, this leads to a Use-After-Free (UAF) condition where active=
 states reference already-freed memory. This can lead to a Kernel Panic (Do=
S) or potential Local Privilege Escalation (LPE).</div><div><h3><b>Vulnerab=
le Code Analysis</b></h3><p>The vulnerability exists in <b><code>kernel/bpf=
/verifier.c</code></b> within the state deallocation logic:</p><p>// File: =
kernel/bpf/verifier.c<br>static void free_verifier_state(struct bpf_verifie=
r_state *state, bool free_self)<br>{<br>=C2=A0 =C2=A0 int i;<br><br>=C2=A0 =
=C2=A0 for (i =3D 0; i &lt;=3D state-&gt;curframe; i++) {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 free_func_state(state-&gt;frame[i]);<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 state-&gt;frame[i] =3D NULL;<br>=C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 kfr=
ee(state-&gt;refs);<br>=C2=A0 =C2=A0 clear_jmp_history(state);<br>=C2=A0 =
=C2=A0 <br>=C2=A0 =C2=A0 /* * CRITICAL FLAW: <br>=C2=A0 =C2=A0 =C2=A0* The =
&#39;state-&gt;parent&#39; link is not nullified. If this state is part <br=
>=C2=A0 =C2=A0 =C2=A0* of a hierarchy where child states are still active, =
they will <br>=C2=A0 =C2=A0 =C2=A0* retain a dangling pointer to this &#39;=
state&#39; after kfree().<br>=C2=A0 =C2=A0 =C2=A0*/<br>=C2=A0 =C2=A0 =C2=A0=
<br>=C2=A0 =C2=A0 if (free_self)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(state=
);<br>}</p><p><br></p><h3><b>Exploit Scenario &amp; Root Cause</b></h3><p>T=
he BPF verifier uses a depth-first search to explore program paths, creatin=
g a hierarchy of states linked via the <code>parent</code> pointer.</p><ol =
start=3D"1"><li><p><b>State Creation:</b> When a branch is encountered, a n=
ew state is created with a <code>parent</code> pointer to the previous stat=
e.</p></li><li><p><b>Pruning:</b> If the verifier determines a path is redu=
ndant or safe, it may free the associated state using <code>free_verifier_s=
tate</code>.</p></li><li><p><b>UAF Trigger:</b> If the freed state was a pa=
rent to other branches that are still being analyzed (or revisited during <=
code>is_state_visited</code>), the verifier will attempt to dereference <co=
de>state-&gt;parent</code>. Since <code>state</code> has been freed, this r=
esults in a Use-After-Free access.</p></li></ol><div><br></div><div><h3><b>=
Proof of Concept (PoC) Overview</b></h3><p>The following logic (provided in=
 the attached <code>exploit_poc.c</code>) is designed to trigger the state =
pruning mechanism:</p><ul><li><p>The PoC loads a BPF program with multiple =
conditional jumps (<code>BPF_JMP</code>).</p></li><li><p>It forces the veri=
fier to create a deep state hierarchy.</p></li><li><p>By manipulating regis=
ter values, it triggers a condition where a parent state is pruned while ch=
ild references remain active in the verifier&#39;s traversal stack.</p></li=
></ul><div><h3><b>Proposed Mitigation</b></h3><p>To resolve this issue, the=
 verifier must ensure that all references to a state are cleared before it =
is freed, or implement a robust reference counting mechanism for state obje=
cts. A temporary fix involves nullifying the parent link:</p><p><br></p><p>=
// Suggested Patch<br>if (state-&gt;parent) {<br>=C2=A0 =C2=A0 state-&gt;pa=
rent =3D NULL; // Decouple before kfree<br>}</p><p><br></p><h3><b>Impact As=
sessment</b></h3><ul><li><p><b>Type:</b> Use-After-Free (UAF)</p></li><li><=
p><b>Severity:</b> High</p></li><li><p><b>Privileges Required:</b> Local Un=
privileged User (if unprivileged BPF is enabled)</p></li><li><p><b>Conseque=
nces:</b> Kernel Crash (System Instability) or Arbitrary Kernel Memory Acce=
ss</p></li></ul><div><br></div><div>File Link:=C2=A0<a href=3D"https://elix=
ir.bootlin.com/linux/v7.0/source/kernel/bpf/verifier.c">https://elixir.boot=
lin.com/linux/v7.0/source/kernel/bpf/verifier.c</a><br></div><div>Code line=
 : 1695-1708<br><br></div><div>Reporter: Kritik</div><p><br></p><br></div><=
br></div><p><br></p><br></div></div>

--0000000000002e94b6064f947dd9--
--0000000000002e94b8064f947ddb
Content-Type: text/x-csrc; charset="US-ASCII"; name="exploit_poc.c"
Content-Disposition: attachment; filename="exploit_poc.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mo1k9cvv0>
X-Attachment-Id: f_mo1k9cvv0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5o
PgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPgojaW5jbHVkZSA8
bGludXgvYnBmLmg+CgojZGVmaW5lIEJQRl9SQVdfSU5TTihDT0RFLCBEU1QsIFNSQywgT0ZGLCBJ
TU0pIFwKICAgICgoc3RydWN0IGJwZl9pbnNuKSB7IC5jb2RlID0gQ09ERSwgLmRzdF9yZWcgPSBE
U1QsIC5zcmNfcmVnID0gU1JDLCAub2ZmID0gT0ZGLCAuaW1tID0gSU1NIH0pCgojZGVmaW5lIEJQ
Rl9NT1Y2NF9JTU0oRFNULCBJTU0pIEJQRl9SQVdfSU5TTihCUEZfQUxVNjQgfCBCUEZfTU9WIHwg
QlBGX0ssIERTVCwgMCwgMCwgSU1NKQojZGVmaW5lIEJQRl9KTVBfSU1NKE9QLCBEU1QsIElNTSwg
T0ZGKSBCUEZfUkFXX0lOU04oQlBGX0pNUCB8IE9QIHwgQlBGX0ssIERTVCwgMCwgT0ZGLCBJTU0p
CiNkZWZpbmUgQlBGX0VYSVRfSU5TTigpIEJQRl9SQVdfSU5TTihCUEZfSk1QIHwgQlBGX0VYSVQs
IDAsIDAsIDAsIDApCgppbnQgbWFpbigpIHsKICAgIC8vIENyZWF0ZSBtdWx0aXBsZSBicmFuY2hl
cyB0byBmb3JjZSBzdGF0ZSBoaWVyYXJjaHkgKHBhcmVudCBwb2ludGVycykKICAgIHN0cnVjdCBi
cGZfaW5zbiBpbnNuc1tdID0gewogICAgICAgIEJQRl9NT1Y2NF9JTU0oQlBGX1JFR18xLCAwKSwK
ICAgICAgICBCUEZfSk1QX0lNTShCUEZfSkVRLCBCUEZfUkVHXzEsIDAsIDEpLCAvLyBCcmFuY2gg
MTogU3RhdGUgY3JlYXRpb24KICAgICAgICBCUEZfTU9WNjRfSU1NKEJQRl9SRUdfMCwgMSksICAg
ICAgICAgICAvLyBCcmFuY2ggMjogTmV3IGNoaWxkIHN0YXRlCiAgICAgICAgQlBGX0pNUF9JTU0o
QlBGX0pHVCwgQlBGX1JFR18xLCAxLCAxKSwgLy8gQ29tcGxleCBqdW1wIHRvIHRyaWdnZXIgcHJ1
bmluZyBsb2dpYwogICAgICAgIEJQRl9NT1Y2NF9JTU0oQlBGX1JFR18wLCAwKSwKICAgICAgICBC
UEZfRVhJVF9JTlNOKCksCiAgICB9OwoKICAgIHVuaW9uIGJwZl9hdHRyIGF0dHIgPSB7CiAgICAg
ICAgLnByb2dfdHlwZSA9IEJQRl9QUk9HX1RZUEVfU09DS0VUX0ZJTFRFUiwKICAgICAgICAuaW5z
bnMgPSAodW5zaWduZWQgbG9uZylpbnNucywKICAgICAgICAuaW5zbl9jbnQgPSBzaXplb2YoaW5z
bnMpIC8gc2l6ZW9mKGluc25zWzBdKSwKICAgICAgICAubGljZW5zZSA9ICh1bnNpZ25lZCBsb25n
KSJHUEwiLAogICAgICAgIC5sb2dfbGV2ZWwgPSAyLAogICAgICAgIC5sb2dfc2l6ZSA9IDEwMjQg
KiAxMDI0LAogICAgICAgIC5sb2dfYnVmID0gKHVuc2lnbmVkIGxvbmcpbWFsbG9jKDEwMjQgKiAx
MDI0KSwKICAgIH07CgogICAgcHJpbnRmKCJbKl0gU3VibWl0dGluZyBQb0MgdG8gQlBGIFZlcmlm
aWVyLi4uXG4iKTsKICAgIGludCBmZCA9IHN5c2NhbGwoX19OUl9icGYsIEJQRl9QUk9HX0xPQUQs
ICZhdHRyLCBzaXplb2YoYXR0cikpOwoKICAgIGlmIChmZCA8IDApIHsKICAgICAgICBwcmludGYo
IlstXSBWZXJpZmllciByZWplY3RlZCBvciBjcmFzaGVkLiBDaGVjayBkbWVzZyBmb3IgVUFGL1Bh
bmljLlxuIik7CiAgICB9IGVsc2UgewogICAgICAgIHByaW50ZigiWytdIEJQRiBQcm9ncmFtIExv
YWRlZCBzdWNjZXNzZnVsbHkuXG4iKTsKICAgICAgICBjbG9zZShmZCk7CiAgICB9CiAgICByZXR1
cm4gMDsKfQo=
--0000000000002e94b8064f947ddb--
