Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1CC367
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190164; cv=none; b=Gwr8jsNXTNE4elHUrb+kbVd9SSrZJNg+B0hjUhgsbNYPKLt0wKGUlPuCwp1dbEvOjOmF6UZpF4ugzQs1Db99Bz3PPytKn4DbzUgTyyODy+ZfH/BDO16XR8Kc5WHEYT0Nb+ae7+/STXQlnSfLGILCvT33Cb6Kbqx+ygevLwFQ2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190164; c=relaxed/simple;
	bh=Lm4/A635a5jSk8NJyf5HfokloGdMpygMez72pHq0QfU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MwKh0sMPccU1zWE0mgaMUiRX8AQN/C0ELPF17S2lPh+7Q051Q/bPn7XZUzyt38bV+sgwS3/B6JhVmo44O0RV02BZFlqXkU8sFOwpEgPd5FuIQvUx/txZwyG/ieCGcXxKrOjP50lyFJyAXJhq0IArKgq1ukbSWzB9/MDTZFm7MzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JebNQw3F; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JebNQw3F"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso560499a12.0
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 17:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712190161; x=1712794961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k9aPL42zG9w344myxSIGK4U/+YUYYhuVeLwo1JYLtUY=;
        b=JebNQw3Fu04CjKMn2PeA7YeW0HPuviAAjTiazLt6ljj0/oHnHLqFUcSqFeallETJRR
         R196WKWkMGVPx61Ktjx8c0Mnfevnf4CRvPJFlgVJ4WkLEI17NHgepM+3lPNgCPKnTPE3
         b3A9zyjbgPHw0RCwodIRaqqu7t3P6mOZ7g+cUdB1W0+ktDrTy6trysRRWpn++jhvAU5R
         vdkYK7jNFrKQpdG7uwgRXuQBlVQk0unJO9vDgRN+sFYQgwLyX88hYgucLL0JpWuQOBYT
         2/T3acM4EENNfA06vKCj2a5oQcVsoVfCjIYk5SAbSdy3CMcKnAFv2h/OKlARrzMhLjOM
         QPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712190161; x=1712794961;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k9aPL42zG9w344myxSIGK4U/+YUYYhuVeLwo1JYLtUY=;
        b=KuSkkMcJ0ASe/a33WVhEaruTe3OY+FveAHN1jchwOtP7jI83XkY4RzpQq6VgC1Pcaj
         UcHlrFGSARJOifvfv8ZECx/q9Wy/GI4TOTkNVn/Oa8ucJMpRyKmESYjRR6tSH7rAgMNy
         QBNumw9KC8J9m2/S/Oimx1TeTaGJOHXjV/FfcSuAa7Jkc6cxn0xit1y2anOWCpiZE1Td
         2qtgOfQgbu/STBlcIFzNSW+w9vjD46jSAnef3tF/W+C7fwm7fCSOnSyDIIkcUyBo9Lw9
         UICiSHt7k/DgN+Hy28Z6HRPFTUT4/QOOjRCqPH+DheXHekprfNB2ea1q/nuug+TQwjv2
         py7A==
X-Forwarded-Encrypted: i=1; AJvYcCWaIUe8LEACU3jNB2BW0oMutulIU76BUspAs67rkPSE8/G2CYsQIZibiC1gvXh3pRKzUC4y2HLw9ucFCxI3Kr1sCpnC
X-Gm-Message-State: AOJu0YwjhM9MEwYGMF8otr1EoYBux6bZfnoKgQHVcaNAuJaGZiUNJ7m5
	gwYcTxVvzRqoUaZ7QatkSC8iXcJSKuk50YN8uFHV0+VdiMs5hlyWJBBu1I1t2QX2AHpYHuMZNud
	I+QLiBAwGC3jIxNlIBcmg+kuzh7Q=
X-Google-Smtp-Source: AGHT+IEWehhFlMuuTffxRMmhGABa7p6gmAXdm5g6b1YNhfQJryg/dTl6MrhDXjyggVvHeBa0NWUPqLwyB46B2rI7Rv0=
X-Received: by 2002:a50:9b5a:0:b0:56e:603:9fc9 with SMTP id
 a26-20020a509b5a000000b0056e06039fc9mr599313edj.3.1712190161055; Wed, 03 Apr
 2024 17:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 4 Apr 2024 02:22:04 +0200
Message-ID: <CAP01T74=OChcu8V2u3bSMas=Lh-y72Y+7my1djn-uSKygBoX+w@mail.gmail.com>
Subject: [Bug Report] Packet drops after trimming skb using bpf_skb_adjust_room
To: John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>
Cc: Kashyap Sanidhya <sanidhya.kashyap@epfl.ch>, rishabh.iyer@berkley.edu, 
	Daniel Borkmann <daniel@iogearbox.net>, Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: multipart/mixed; boundary="00000000000056b8f206153a56ef"

--00000000000056b8f206153a56ef
Content-Type: text/plain; charset="UTF-8"

Hello John,

For background, I have a sk_skb program where for certain flows, a
subset of request handling logic (on Rx) that is typically done in
user space is handed over to a BPF program for doing it in-kernel.

Since the protocol is over TCP, I'm using sk_skb programs to handle
these requests and generate responses from within the kernel. The user
space application will decide which flow should be added to the
sockmap on socket accept and then let it be handled in the kernel for
some of the request types.

However, when generating replies and trimming away extra bytes in the
packet by using bpf_skb_adjust_room, I see packet drops because the
strp_msg->full_len is not updated unless tls_sw_has_ctx_rx is true for
the socket. Removing that condition makes everything work, but I am
not sure that is the right fix.

My understanding so far is that in sk_psock_backlog,
sk_psock_handle_skb returns an error since the stm->full_len is not
correct (and passed into it as len), and SK_PSOCK_TX_ENABLED gets
cleared due to this error. Then, on the redirect side
(sk_psock_skb_redirect), it does sock_drop because the test for the
SK_PSOCK_TX_ENABLED flag fails, which does kfree_skb.

I have attached a patch with a selftest (skb_adjust_room) that you can
run to verify the problem. It should basically hang on the second read
as the packet would be dropped by the kernel. The first read goes
through fine. Applying the diff below allows the selftest to pass.

I am not familiar with the code to know whether the fix below is
correct, but it seems to resolve the problem for me (and I carried it
for a while and ran my stuff on it until I got around to reporting
this now).

In case gmail screws up the formatting, I'm just removing the
tls_sw_has_ctx_rx(skb->sk) conditional on the strp_msg->full_len
update in sk_skb_adjust_room.

diff --git a/net/core/filter.c b/net/core/filter.c
index 524adf1fa6d0..e3009d0f3352 100644

--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3622,11 +3622,7 @@ BPF_CALL_4(sk_skb_adjust_room, struct sk_buff
*, skb, s32, len_diff,

                        return -ENOMEM;

                __skb_pull(skb, len_diff_abs);

        }

-       if (tls_sw_has_ctx_rx(skb->sk)) {
-               struct strp_msg *rxm = strp_msg(skb);
-
-               rxm->full_len += len_diff;
-       }
+       strp_msg(skb)->full_len += len_diff;
        return ret;
 }

--

Thanks!

--00000000000056b8f206153a56ef
Content-Type: application/octet-stream; name="test.patch"
Content-Disposition: attachment; filename="test.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lukhmvie0>
X-Attachment-Id: f_lukhmvie0

RnJvbSBlZWEyZDEzNDBmOTkxYjg3Y2U2NTk1MjE4NDEwNmJiOTNkM2Y5ZGRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaSA8bWVteG9yQGdtYWls
LmNvbT4KRGF0ZTogVGh1LCA0IEFwciAyMDI0IDAwOjEyOjUwICswMDAwClN1YmplY3Q6IFtQQVRD
SF0gc2VsZnRlc3RzL2JwZjogVGVzdCBjYXNlIHRvIHZlcmlmeSBicGZfc2tiX2FkanVzdF9yb29t
IGZpeAoKU2lnbmVkLW9mZi1ieTogS3VtYXIgS2FydGlrZXlhIER3aXZlZGkgPG1lbXhvckBnbWFp
bC5jb20+Ci0tLQogLi4uL2JwZi9wcm9nX3Rlc3RzL3NrYl9hZGp1c3Rfcm9vbS5jICAgICAgICAg
IHwgNzggKysrKysrKysrKysrKysrKysrKwogLi4uL3NlbGZ0ZXN0cy9icGYvcHJvZ3Mvc2tiX2Fk
anVzdF9yb29tLmMgICAgIHwgNDYgKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTI0IGlu
c2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9i
cGYvcHJvZ190ZXN0cy9za2JfYWRqdXN0X3Jvb20uYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy9za2JfYWRqdXN0X3Jvb20uYwoKZGlmZiAtLWdp
dCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3NrYl9hZGp1c3Rfcm9v
bS5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvc2tiX2FkanVzdF9y
b29tLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi5kMTNiOWFjNWRj
MWIKLS0tIC9kZXYvbnVsbAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190
ZXN0cy9za2JfYWRqdXN0X3Jvb20uYwpAQCAtMCwwICsxLDc4IEBACisvLyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMAorI2luY2x1ZGUgPHRlc3RfcHJvZ3MuaD4KKworI2luY2x1ZGUg
InNrYl9hZGp1c3Rfcm9vbS5za2VsLmgiCisKK3ZvaWQgdGVzdF9za2JfYWRqdXN0X3Jvb20odm9p
ZCkKK3sKKwlzdHJ1Y3Qgc2tiX2FkanVzdF9yb29tICpza2VsOworCWludCBza1szXSA9IHstMSwg
LTEsIC0xfTsKKwlzdHJ1Y3Qgc29ja2FkZHJfaW4gc2VydjsKKwljaGFyIGJ1Zls4XTsKKwlpbnQg
ZXJyOworCisJc2tlbCA9IHNrYl9hZGp1c3Rfcm9vbV9fb3Blbl9hbmRfbG9hZCgpOworCWlmICgh
QVNTRVJUX09LX1BUUihza2VsLCAic2tiX2FkanVzdF9yb29tX19vcGVuX2FuZF9sb2FkIikpCisJ
CXJldHVybjsKKwllcnIgPSBicGZfcHJvZ19hdHRhY2goYnBmX3Byb2dyYW1fX2ZkKHNrZWwtPnBy
b2dzLnByb2dfc2tiX3BhcnNlciksIGJwZl9tYXBfX2ZkKHNrZWwtPm1hcHMuc29ja21hcCksIEJQ
Rl9TS19TS0JfU1RSRUFNX1BBUlNFUiwgMCk7CisJaWYgKCFBU1NFUlRfT0soZXJyLCAiYnBmX3By
b2dfYXR0YWNoIHBhcnNlciIpKQorCQlyZXR1cm47CisJZXJyID0gYnBmX3Byb2dfYXR0YWNoKGJw
Zl9wcm9ncmFtX19mZChza2VsLT5wcm9ncy5wcm9nX3NrYl92ZXJkaWN0KSwgYnBmX21hcF9fZmQo
c2tlbC0+bWFwcy5zb2NrbWFwKSwgQlBGX1NLX1NLQl9TVFJFQU1fVkVSRElDVCwgMCk7CisJaWYg
KCFBU1NFUlRfT0soZXJyLCAiYnBmX3Byb2dfYXR0YWNoIHZlcmRpY3QiKSkKKwkJcmV0dXJuOwor
CS8vIFNlcnZlcgorCXNrWzBdID0gc29ja2V0KEFGX0lORVQsIFNPQ0tfU1RSRUFNLCAwKTsKKwlp
ZiAoIUFTU0VSVF9HRShza1swXSwgMCwgInNlcnZlciBzb2NrIikpCisJCXJldHVybjsKKwltZW1z
ZXQoJnNlcnYsIDAsIHNpemVvZihzZXJ2KSk7CisJc2Vydi5zaW5fZmFtaWx5ID0gQUZfSU5FVDsK
KwlzZXJ2LnNpbl9hZGRyLnNfYWRkciA9IGh0b25sKElOQUREUl9BTlkpOworCXNlcnYuc2luX3Bv
cnQgPSBodG9ucyg2OTY5KTsKKworCWVyciA9IGJpbmQoc2tbMF0sIChzdHJ1Y3Qgc29ja2FkZHIg
Kikmc2Vydiwgc2l6ZW9mKHNlcnYpKTsKKwlpZiAoIUFTU0VSVF9PSyhlcnIsICJiaW5kIGxvY2Fs
aG9zdDo2OTY5IikpCisJCWdvdG8gZW5kOworCWVyciA9IGxpc3Rlbihza1swXSwgMSk7CisJaWYg
KCFBU1NFUlRfT0soZXJyLCAibGlzdGVuIHdpdGggYmFja2xvZyA9IDEiKSkKKwkJZ290byBlbmQ7
CisKKwkvLyBDbGllbnQKKwlza1sxXSA9IHNvY2tldChBRl9JTkVULCBTT0NLX1NUUkVBTSwgMCk7
CisJaWYgKCFBU1NFUlRfR0Uoc2tbMV0sIDAsICJjbGllbnQgc29jayIpKQorCQlnb3RvIGVuZDsK
KwltZW1zZXQoJnNlcnYsIDAsIHNpemVvZihzZXJ2KSk7CisJc2Vydi5zaW5fZmFtaWx5ID0gQUZf
SU5FVDsKKwlzZXJ2LnNpbl9hZGRyLnNfYWRkciA9IGluZXRfYWRkcigiMTI3LjAuMC4xIik7CisJ
c2Vydi5zaW5fcG9ydCA9IGh0b25zKDY5NjkpOworCisJZXJyID0gY29ubmVjdChza1sxXSwgKHN0
cnVjdCBzb2NrYWRkciAqKSZzZXJ2LCBzaXplb2Yoc2VydikpOworCWlmICghQVNTRVJUX09LKGVy
ciwgImNvbm5lY3QgbG9jYWxob3N0OjY5NjkiKSkKKwkJZ290byBlbmQ7CisKKwlza1syXSA9IGFj
Y2VwdChza1swXSwgTlVMTCwgTlVMTCk7CisJaWYgKCFBU1NFUlRfR0Uoc2tbMl0sIDAsICJhY2Nl
cHQgc29jayIpKQorCQlnb3RvIGVuZDsKKwllcnIgPSBicGZfbWFwX191cGRhdGVfZWxlbShza2Vs
LT5tYXBzLnNvY2ttYXAsICYoaW50KXswfSwgNCwgc2sgKyAyLCA0LCAwKTsKKwlpZiAoIUFTU0VS
VF9PSyhlcnIsICJhZGQgc2VydmVyIHNvY2sgdG8gc29ja21hcCIpKQorCQlnb3RvIGVuZDsKKwor
CWZvciAoaW50IGkgPSAwOyBpIDwgMTA7IGkrKykgeworCQllcnIgPSB3cml0ZShza1sxXSwgIjEy
MzQ1NjciLCA4KTsKKwkJaWYgKCFBU1NFUlRfRVEoZXJyLCA4LCAid3JpdGUgZnJvbSBjbGllbnQi
KSkKKwkJCWdvdG8gZW5kOworCQllcnIgPSByZWFkKHNrWzFdLCBidWYsIDMpOworCQlpZiAoIUFT
U0VSVF9FUShlcnIsIDMsICJyZWFkIGZyb20gY2xpZW50IikpCisJCQlnb3RvIGVuZDsKKwl9CisJ
aWYgKCFBU1NFUlRfRVEoc3RyY21wKGJ1ZiwgIk9LIiksIDAsICJzdHJjbXAgcmVzcG9uc2UiKSkK
KwkJZ290byBlbmQ7CisJLy8gRG9uZSEKK2VuZDoKKwlpZiAoc2tbMF0gPj0gMCkKKwkJY2xvc2Uo
c2tbMF0pOworCWlmIChza1sxXSA+PSAwKQorCQljbG9zZShza1sxXSk7CisJaWYgKHNrWzJdID49
IDApCisJCWNsb3NlKHNrWzJdKTsKKwlyZXR1cm47Cit9CmRpZmYgLS1naXQgYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3Mvc2tiX2FkanVzdF9yb29tLmMgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9icGYvcHJvZ3Mvc2tiX2FkanVzdF9yb29tLmMKbmV3IGZpbGUgbW9kZSAxMDA2
NDQKaW5kZXggMDAwMDAwMDAwMDAwLi42ZGU5YWU5N2U0NWUKLS0tIC9kZXYvbnVsbAorKysgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3Mvc2tiX2FkanVzdF9yb29tLmMKQEAgLTAs
MCArMSw0NiBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKKyNpbmNsdWRl
IDx2bWxpbnV4Lmg+CisjaW5jbHVkZSA8YnBmL2JwZl9oZWxwZXJzLmg+CisKK3N0cnVjdCB7CisJ
X191aW50KHR5cGUsIEJQRl9NQVBfVFlQRV9TT0NLTUFQKTsKKwlfX3VpbnQobWF4X2VudHJpZXMs
IDEpOworCV9fdHlwZShrZXksIGludCk7CisJX190eXBlKHZhbHVlLCBpbnQpOworfSBzb2NrbWFw
IFNFQygiLm1hcHMiKTsKKworU0VDKCJza19za2Ivc3RyZWFtX3BhcnNlciIpCitpbnQgcHJvZ19z
a2JfcGFyc2VyKHN0cnVjdCBfX3NrX2J1ZmYgKnNrYikKK3sKKwlyZXR1cm4gc2tiLT5sZW47Cit9
CisKK1NFQygic2tfc2tiL3N0cmVhbV92ZXJkaWN0IikKK2ludCBwcm9nX3NrYl92ZXJkaWN0KHN0
cnVjdCBfX3NrX2J1ZmYgKnNrYikKK3sKKwl2b2lkICpkYXRhLCAqZGF0YV9lbmQ7CisJaW50IGtl
eSA9IDA7CisKKwlpZiAoYnBmX3NrYl9wdWxsX2RhdGEoc2tiLCBza2ItPmxlbikpIHsKKwkJYnBm
X3ByaW50aygiZXJyIGxlbj0lZFxuIiwgc2tiLT5sZW4pOworCQlyZXR1cm4gU0tfUEFTUzsKKwl9
CisKKwlkYXRhX2VuZCA9ICh2b2lkICopKGxvbmcpc2tiLT5kYXRhX2VuZDsKKwlkYXRhID0gKHZv
aWQgKikobG9uZylza2ItPmRhdGE7CisKKwlpZiAoZGF0YSArIDQgPiBkYXRhX2VuZCkgeworCQli
cGZfcHJpbnRrKCJlcnIgbGVuPSVkIGRhdGFfZW5kLWRhdGE9JWRcbiIsIHNrYi0+bGVuLCBkYXRh
X2VuZCAtIGRhdGEpOworCQlyZXR1cm4gU0tfUEFTUzsKKwl9CisJY2hhciAqYnVmID0gZGF0YTsK
KwlicGZfcHJpbnRrKCJza2I9MHglbGx4IGRhdGE6ICVjJWMlYyVjXG4iLCAobG9uZyBsb25nKXNr
YiwgYnVmWzBdLCBidWZbMV0sIGJ1ZlsyXSwgYnVmWzNdKTsKKwlfX2J1aWx0aW5fbWVtY3B5KGRh
dGEsICJPSyIsIDMpOworCWlmIChicGZfc2tiX2FkanVzdF9yb29tKHNrYiwgMyAtIHNrYi0+bGVu
LCAwLCAwKSkgeworCQlicGZfcHJpbnRrKCJlcnJcbiIpOworCQlyZXR1cm4gU0tfUEFTUzsKKwl9
CisJcmV0dXJuIGJwZl9za19yZWRpcmVjdF9tYXAoc2tiLCAmc29ja21hcCwga2V5LCAwKTsKK30K
KworY2hhciBfbGljZW5zZVtdIFNFQygibGljZW5zZSIpID0gIkdQTCI7Ci0tIAoyLjQzLjAKCg==
--00000000000056b8f206153a56ef--
